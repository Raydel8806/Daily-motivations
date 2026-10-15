import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/localization/app_strings.dart';
import '../features/settings/data/language_preferences.dart';
import '../features/quotes/presentation/quote_page.dart';
import '../features/favorites/data/favorites_store.dart';
import '../features/reminders/data/daily_reminder_service.dart';

class DailyMotivationsApp extends StatefulWidget {
  const DailyMotivationsApp(
      {Key? key,
      this.initialLocale,
      this.onLanguageSaved,
      this.favoritesStore,
      this.reminderService})
      : super(key: key);

  final Locale? initialLocale;
  final Future<void> Function(Locale?)? onLanguageSaved;
  final FavoritesStore? favoritesStore;
  final DailyReminderService? reminderService;

  @override
  State<DailyMotivationsApp> createState() => _DailyMotivationsAppState();
}

class _DailyMotivationsAppState extends State<DailyMotivationsApp> {
  Locale? _locale;
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  late final FavoritesStore _favorites;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
    _favorites = widget.favoritesStore ?? FavoritesStore();
  }

  @override
  void dispose() {
    if (widget.favoritesStore == null) _favorites.dispose();
    super.dispose();
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
      return;
    }
    try {
      await widget.reminderService?.updateLanguage(locale?.languageCode);
    } catch (error) {
      debugPrint('Could not update the reminder language: $error');
      if (mounted) {
        _messengerKey.currentState?.showSnackBar(
          SnackBar(
              content: Text(AppStrings(_locale?.languageCode ??
                      LanguagePreferences.resolveDeviceLanguage(
                              WidgetsBinding
                                  .instance.platformDispatcher.locales,
                              LanguagePreferences.supportedLocales)
                          .languageCode)
                  .reminderError)),
        );
      }
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
      home: QuotePage(
        reminderService: widget.reminderService,
        favoritesStore: _favorites,
        selectedLocale: _locale,
        onLanguageChanged: _changeLanguage,
      ),
    );
  }
}
