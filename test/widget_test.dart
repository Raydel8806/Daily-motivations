import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motivaciones_diarias/main.dart';
import 'package:motivaciones_diarias/app_strings.dart';
import 'package:motivaciones_diarias/quote_provider.dart';
import 'package:motivaciones_diarias/quote_translations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Every calendar date has an offline English and French translation',
      () async {
    await QuoteTranslations.load();
    final quotes = QuoteProvider().listOfQuotes;
    expect(quotes.length, 366);
    expect(quotes.map((quote) => quote.date).toSet().length, 366);
    for (final quote in quotes) {
      expect(quote.quote, isNot(contains('&#')));
      expect(quote.author, quote.author.trim());
      expect(
          QuoteTranslations.displayText(quote, 'es').endsWith('..'), isFalse);
    }
    for (final language in ['en', 'fr']) {
      final data = jsonDecode(
          await rootBundle.loadString('assets/quotes_$language.json')) as Map;
      expect(data.keys.toSet(), quotes.map((q) => q.date).toSet());
      for (final quote in quotes) {
        expect(data[quote.date], isA<String>());
        expect((data[quote.date] as String).trim(), isNotEmpty);
        expect(data[quote.date], isNot(contains('&#')));
        expect(QuoteTranslations.text(quote, language), data[quote.date]);
        expect(QuoteTranslations.shareText(quote, language),
            '${QuoteTranslations.displayText(quote, language)}\n${QuoteTranslations.author(quote, language)}');
        expect(QuoteTranslations.displayText(quote, language).endsWith('..'),
            isFalse);
      }
    }
    expect(AppStrings('en').date('Febrero 29'), 'February 29');
    expect(AppStrings('fr').date('Febrero 29'), '29 février');
    expect(AppStrings('es').date('Febrero 29'), '29 de febrero');
    final proverb = QuoteProvider().getQuoteByDay('Febrero 27');
    expect(QuoteTranslations.author(proverb, 'en'), 'Japanese proverb');
    expect(QuoteTranslations.author(proverb, 'fr'), 'Proverbe japonais');
  });

  testWidgets('Language changes translate the selected quote and calendar',
      (tester) async {
    tester.binding.platformDispatcher.localesTestValue = const [Locale('es')];
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
    await tester.runAsync(QuoteTranslations.load);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Motivaciones Diarias'), findsOneWidget);
    final now = DateTime.now();
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
    final quote =
        QuoteProvider().getQuoteByDay('${months[now.month - 1]} ${now.day}');
    for (final entry in {
      'English': ['en', 'Daily Motivations'],
      'Français': ['fr', 'Motivations quotidiennes'],
      'Español': ['es', 'Motivaciones Diarias']
    }.entries) {
      await tester.tap(find.byIcon(Icons.language));
      await tester.pumpAndSettle();
      await tester.tap(find.text(entry.key));
      await tester.pumpAndSettle();
      expect(find.text(entry.value[1]), findsOneWidget);
      expect(find.text(QuoteTranslations.displayText(quote, entry.value[0])),
          findsOneWidget);
      expect(find.text(AppStrings(entry.value[0]).date(quote.date)),
          findsOneWidget);
    }
    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Français'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rechercher par date'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Citation du jour'));
    await tester.pumpAndSettle();
    final calendarContext = tester.element(find.byType(DatePickerDialog));
    expect(Localizations.localeOf(calendarContext).languageCode, 'fr');
    expect(
        find.text(MaterialLocalizations.of(calendarContext).cancelButtonLabel),
        findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
