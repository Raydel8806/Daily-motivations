import 'package:flutter/material.dart';
import 'app/app.dart';
import 'features/quotes/data/quote_translations.dart';
import 'features/settings/data/language_preferences.dart';
import 'features/favorites/data/favorites_store.dart';
import 'features/reminders/data/daily_reminder_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await QuoteTranslations.load();
  final preferences = LanguagePreferences();
  Locale? savedLocale;
  try {
    savedLocale = await preferences.load();
  } catch (error) {
    debugPrint('Could not load the language preference: $error');
  }
  final favorites = FavoritesStore();
  try {
    await favorites.load();
  } catch (error) {
    debugPrint('Could not load favorites: $error');
  }
  final reminders = DailyReminderService();
  try {
    await reminders.initialize(savedLocale?.languageCode);
  } catch (error) {
    debugPrint('Could not initialize reminders: $error');
  }
  runApp(DailyMotivationsApp(
      reminderService: reminders,
      favoritesStore: favorites,
      initialLocale: savedLocale,
      onLanguageSaved: preferences.save));
}
