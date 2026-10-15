import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motivaciones_diarias/app/app.dart';
import 'package:motivaciones_diarias/features/quotes/data/quote_translations.dart';
import 'package:motivaciones_diarias/features/reminders/data/daily_reminder_service.dart';
import 'package:motivaciones_diarias/features/reminders/models/reminder_settings.dart';
import 'package:motivaciones_diarias/features/reminders/presentation/reminder_settings_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('daily_motivations/test_reminders');
  final calls = <MethodCall>[];
  var settings = const ReminderSettings();
  var permitted = true;

  setUp(() {
    calls.clear();
    settings = const ReminderSettings();
    permitted = true;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      switch (call.method) {
        case 'settings':
          return settings.toMap();
        case 'requestPermission':
          return permitted;
        case 'configure':
          if (!permitted && (call.arguments as Map)['enabled'] == true) {
            return false;
          }
          settings = ReminderSettings.fromMap(call.arguments as Map);
          return true;
        case 'preview':
          return permitted;
        case 'consumeOpenedDate':
          return '2028-02-29';
        default:
          return null;
      }
    });
  });
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('Notification catalogs include every language and the leap day',
      () async {
    await QuoteTranslations.load();
    final service = DailyReminderService(channel: channel);
    await service.initialize('fr');
    final arguments =
        calls.firstWhere((c) => c.method == 'initialize').arguments as Map;
    final catalogs = jsonDecode(arguments['catalogs'] as String) as Map;
    for (final language in ['es', 'en', 'fr']) {
      expect((catalogs[language] as Map).length, 366);
      expect((catalogs[language] as Map)['Febrero 29'], isNotEmpty);
    }
    expect(arguments['manualLanguage'], 'fr');
    expect(service.openedDate.value, DateTime(2028, 2, 29));
    await service.updateLanguage(null);
    expect((calls.last.arguments as Map)['manualLanguage'], isNull);
  });

  testWidgets('Permission denial does not enable a reminder', (tester) async {
    permitted = false;
    await tester.pumpWidget(MaterialApp(
        home: ReminderSettingsPage(
            service: DailyReminderService(channel: channel))));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(settings.enabled, isFalse);
    expect(calls.any((call) => call.method == 'configure'), isFalse);
    expect(
        find.text(
            'Notifications are disabled. You can allow them in your phone settings.'),
        findsOneWidget);
    permitted = true;
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(settings.enabled, isTrue);
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(settings.enabled, isFalse);
  });

  testWidgets(
      'Opening a notification selects its date while preserving language',
      (tester) async {
    await tester.runAsync(QuoteTranslations.load);
    final service = DailyReminderService(channel: channel);
    service.openedDate.value = DateTime(2028, 2, 29);
    await tester.pumpWidget(DailyMotivationsApp(
        initialLocale: const Locale('fr'), reminderService: service));
    await tester.pumpAndSettle();
    expect(find.text('29 février'), findsOneWidget);
    expect(find.text('Motivations quotidiennes'), findsOneWidget);
    expect(service.openedDate.value, isNull);
    service.openedDate.value = DateTime(2027, 1, 1);
    await tester.pumpAndSettle();
    expect(find.text('1 janvier'), findsOneWidget);
    service.openedDate.value = DateTime(2028, 2, 29);
    await tester.pumpAndSettle();
    expect(find.text('29 février'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
