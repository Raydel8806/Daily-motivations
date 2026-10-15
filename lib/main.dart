import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_strings.dart';
import 'quote_translations.dart';
import 'language_preferences.dart';
import 'my_home_page.dart';

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
  runApp(MyApp(initialLocale: savedLocale, onLanguageSaved: preferences.save));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.initialLocale, this.onLanguageSaved})
      : super(key: key);

  final Locale? initialLocale;
  final Future<void> Function(Locale?)? onLanguageSaved;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  Future<void> _changeLanguage(Locale? locale) async {
    setState(() => _locale = locale);
    try {
      await widget.onLanguageSaved?.call(locale);
    } catch (error) {
      debugPrint('Could not save the language preference: $error');
      if (!mounted) return;
      final strings = AppStrings(_locale?.languageCode ??
          LanguagePreferences.resolveDeviceLanguage(
                  WidgetsBinding.instance.platformDispatcher.locales,
                  LanguagePreferences.supportedLocales)
              .languageCode);
      _messengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(strings.languageSaveError)),
      );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppStrings.of(context).title,
      locale: _locale,
      supportedLocales: LanguagePreferences.supportedLocales,
      localeListResolutionCallback: LanguagePreferences.resolveDeviceLanguage,
      scaffoldMessengerKey: _messengerKey,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(
        selectedLocale: _locale,
        onLanguageChanged: _changeLanguage,
      ),
    );
  }
}
