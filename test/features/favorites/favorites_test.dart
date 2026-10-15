import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motivaciones_diarias/app/app.dart';
import 'package:motivaciones_diarias/features/favorites/data/favorites_store.dart';
import 'package:motivaciones_diarias/features/quotes/data/quote_catalog.dart';
import 'package:motivaciones_diarias/features/quotes/data/quote_translations.dart';
import '../../support/memory_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Favorites survive a fresh store and ignore unknown or duplicated IDs',
      () async {
    final disk = MemoryPreferences();
    disk.values[FavoritesStore.storageKey] = [
      'Febrero 29',
      'invalid',
      'Febrero 29'
    ];
    final store = FavoritesStore(storage: disk);
    await store.load();
    expect(store.quotes.map((quote) => quote.date), ['Febrero 29']);
    final quote = QuoteCatalog().forDate(DateTime(2024, 1, 1));
    await store.toggle(quote);
    final restarted = FavoritesStore(storage: disk);
    await restarted.load();
    expect(restarted.contains(quote), isTrue);
    await restarted.toggle(quote);
    final again = FavoritesStore(storage: disk);
    await again.load();
    expect(again.contains(quote), isFalse);
    expect(again.quotes.single.date, 'Febrero 29');
    store.dispose();
    restarted.dispose();
    again.dispose();
  });

  test('Failed writes preserve favorites and later changes can be saved',
      () async {
    final disk = MemoryPreferences();
    final store = FavoritesStore(storage: disk);
    final quote = QuoteCatalog().forDate(DateTime(2024, 1, 1));
    await store.load();
    disk.failWrites = true;
    await expectLater(store.toggle(quote), throwsStateError);
    expect(store.contains(quote), isFalse);
    disk.failWrites = false;
    await Future.wait([store.toggle(quote), store.toggle(quote)]);
    expect(store.contains(quote), isFalse);
    await store.toggle(quote);
    expect(store.contains(quote), isTrue);
    store.dispose();
  });

  testWidgets('Save, translate, open, and remove a favorite', (tester) async {
    tester.binding.platformDispatcher.localesTestValue = const [Locale('en')];
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
    await tester.runAsync(QuoteTranslations.load);
    final store = FavoritesStore(storage: MemoryPreferences());
    await store.load();
    await tester.pumpWidget(DailyMotivationsApp(favoritesStore: store));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('toggle_favorite')));
    await tester.pumpAndSettle();
    expect(store.quotes.length, 1);
    final quote = store.quotes.single;
    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(QuoteTranslations.displayText(quote, 'en')));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Français'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Favoris'));
    await tester.pumpAndSettle();
    expect(
        find.text(QuoteTranslations.displayText(quote, 'fr')), findsOneWidget);
    await tester.tap(find.byTooltip('Retirer des favoris'));
    await tester.pumpAndSettle();
    expect(store.quotes, isEmpty);
    expect(
        find.text(
            'Aucun favori pour le moment. Enregistrez une citation avec le cœur.'),
        findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    store.dispose();
  });
}
