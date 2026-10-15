import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motivaciones_diarias/app/app.dart';
import 'package:motivaciones_diarias/features/quotes/data/quote_catalog.dart';
import 'package:motivaciones_diarias/features/quotes/data/quote_translations.dart';
import 'package:motivaciones_diarias/features/reminders/data/daily_reminder_service.dart';

void main() {
  testWidgets(
      'Longest quotes remain readable on a small screen with large text',
      (tester) async {
    await tester.runAsync(QuoteTranslations.load);
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    for (final language in ['es', 'en', 'fr']) {
      final quotes = QuoteCatalog().quotes.toList()
        ..sort((a, b) => QuoteTranslations.displayText(b, language)
            .length
            .compareTo(QuoteTranslations.displayText(a, language).length));
      final quote = quotes.first;
      final parts = quote.date.split(' ');
      const months = [
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto',
        'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre'
      ];
      final service = DailyReminderService();
      service.openedDate.value = DateTime(
          2024, months.indexOf(parts.first) + 1, int.parse(parts.last));
      await tester.pumpWidget(DailyMotivationsApp(
        key: ValueKey(language),
        initialLocale: Locale(language),
        reminderService: service,
      ));
      await tester.pumpAndSettle();
      expect(find.text(QuoteTranslations.displayText(quote, language)),
          findsOneWidget);
      await tester.ensureVisible(find.byKey(const ValueKey('toggle_favorite')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      service.openedDate.dispose();
    }
  });
}
