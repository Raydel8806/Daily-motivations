import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  LanguagePreferences({SharedPreferencesAsync? storage})
      : _storage = storage ?? SharedPreferencesAsync();

  static const storageKey = 'selected_language';
  static const supportedLocales = [Locale('es'), Locale('en'), Locale('fr')];
  final SharedPreferencesAsync _storage;
  Future<void> _pendingWrite = Future<void>.value();

  Future<Locale?> load() async {
    final language = await _storage.getString(storageKey);
    for (final locale in supportedLocales) {
      if (locale.languageCode == language) return locale;
    }
    return null;
  }

  Future<void> save(Locale? locale) {
    final write = _pendingWrite.then((_) async {
      if (locale == null) {
        await _storage.remove(storageKey);
      } else {
        await _storage.setString(storageKey, locale.languageCode);
      }
    });
    // Keep later selections writable even if an earlier storage request fails.
    _pendingWrite = write.catchError((Object _) {});
    return write;
  }

  static Locale resolveDeviceLanguage(
      List<Locale>? preferredLocales, Iterable<Locale> supported) {
    for (final preferred in preferredLocales ?? <Locale>[]) {
      for (final locale in supported) {
        if (locale.languageCode == preferred.languageCode) return locale;
      }
    }
    return const Locale('en');
  }
}
