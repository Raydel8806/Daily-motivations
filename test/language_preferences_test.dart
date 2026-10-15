import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:motivaciones_diarias/language_preferences.dart';
import 'package:motivaciones_diarias/main.dart';
import 'package:motivaciones_diarias/quote_translations.dart';

class MemoryPreferencesState {
  Completer<void>? writeGate;
  bool failWrites = false;
}

class MemoryPreferences extends Fake implements SharedPreferencesAsync {
  final Map<String, String> values = {};
  final _state = MemoryPreferencesState();
  Completer<void>? get writeGate => _state.writeGate;
  set writeGate(Completer<void>? value) => _state.writeGate = value;
  bool get failWrites => _state.failWrites;
  set failWrites(bool value) => _state.failWrites = value;

  @override
  Future<String?> getString(String key) async => values[key];

  @override
  Future<void> setString(String key, String value) async {
    if (failWrites) throw StateError('Storage unavailable');
    await writeGate?.future;
    values[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    if (failWrites) throw StateError('Storage unavailable');
    values.remove(key);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Unsupported or missing device languages fall back to English', () {
    for (final locales in <List<Locale>?>[
      null,
      [],
      [const Locale('de', 'DE')],
      [const Locale('pt', 'BR'), const Locale('it', 'IT')],
    ]) {
      expect(
          LanguagePreferences.resolveDeviceLanguage(
              locales, LanguagePreferences.supportedLocales),
          const Locale('en'));
    }
    expect(
        LanguagePreferences.resolveDeviceLanguage(
            [const Locale('de'), const Locale('fr', 'CA')],
            LanguagePreferences.supportedLocales),
        const Locale('fr'));
  });

  test('Only supported saved preferences override the device language',
      () async {
    final storage = MemoryPreferences();
    final preferences = LanguagePreferences(storage: storage);
    expect(await preferences.load(), isNull);
    storage.values[LanguagePreferences.storageKey] = 'invalid';
    expect(await preferences.load(), isNull);
    for (final language in ['es', 'en', 'fr']) {
      await preferences.save(Locale(language));
      expect(
          await LanguagePreferences(storage: storage).load(), Locale(language));
    }
    await preferences.save(null);
    expect(await LanguagePreferences(storage: storage).load(), isNull);
  });

  test('Rapid selections persist the final choice after delayed writes',
      () async {
    final storage = MemoryPreferences()..writeGate = Completer<void>();
    final preferences = LanguagePreferences(storage: storage);
    final first = preferences.save(const Locale('es'));
    final second = preferences.save(const Locale('fr'));
    storage.writeGate!.complete();
    await Future.wait([first, second]);
    expect(
        await LanguagePreferences(storage: storage).load(), const Locale('fr'));
  });

  for (final entry in {
    const Locale('es', 'MX'): 'Motivaciones Diarias',
    const Locale('en', 'GB'): 'Daily Motivations',
    const Locale('fr', 'CA'): 'Motivations quotidiennes',
    const Locale('de', 'DE'): 'Daily Motivations',
  }.entries) {
    testWidgets('Cold launch follows device locale ${entry.key}',
        (tester) async {
      tester.binding.platformDispatcher.localesTestValue = [entry.key];
      addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
      await tester.runAsync(QuoteTranslations.load);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.text(entry.value), findsOneWidget);
    });
  }

  testWidgets(
      'Manual selection survives restart and device mode stays automatic',
      (tester) async {
    final storage = MemoryPreferences();
    tester.binding.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
    await tester.runAsync(QuoteTranslations.load);

    Future<void> launch() async {
      final preferences = LanguagePreferences(storage: storage);
      final locale = await preferences.load();
      await tester.pumpWidget(
          MyApp(initialLocale: locale, onLanguageSaved: preferences.save));
      await tester.pumpAndSettle();
    }

    await launch();
    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('Daily Motivations'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    tester.binding.platformDispatcher.localesTestValue = const [Locale('es')];
    await launch();
    expect(find.text('Daily Motivations'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Device language'));
    await tester.pumpAndSettle();
    expect(find.text('Motivaciones Diarias'), findsOneWidget);
    expect(storage.values.containsKey(LanguagePreferences.storageKey), isFalse);

    await tester.pumpWidget(const SizedBox());
    tester.binding.platformDispatcher.localesTestValue = const [Locale('fr')];
    await launch();
    expect(find.text('Motivations quotidiennes'), findsOneWidget);
  });

  testWidgets('Failed saving shows a localized message and a retry can succeed',
      (tester) async {
    final storage = MemoryPreferences()..failWrites = true;
    final preferences = LanguagePreferences(storage: storage);
    tester.binding.platformDispatcher.localesTestValue = const [Locale('es')];
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
    await tester.runAsync(QuoteTranslations.load);
    await tester.pumpWidget(MyApp(onLanguageSaved: preferences.save));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('Could not save the language. Please try again.'),
        findsOneWidget);
    expect(storage.values.containsKey(LanguagePreferences.storageKey), isFalse);
    storage.failWrites = false;
    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Français'));
    await tester.pumpAndSettle();
    expect(await preferences.load(), const Locale('fr'));
    expect(tester.takeException(), isNull);
  });
}
