import 'package:flutter/material.dart';
import 'app/app.dart';
import 'features/quotes/data/quote_translations.dart';
import 'features/settings/data/language_preferences.dart';

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
  runApp(DailyMotivationsApp(
      initialLocale: savedLocale, onLanguageSaved: preferences.save));
}
