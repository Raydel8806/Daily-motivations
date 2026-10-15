import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../../quotes/data/quote_catalog.dart';
import '../../quotes/data/quote_translations.dart';
import '../models/reminder_settings.dart';

class DailyReminderService {
  DailyReminderService({MethodChannel? channel})
      : _channel =
            channel ?? const MethodChannel('daily_motivations/reminders');

  final MethodChannel _channel;
  final openedDate = ValueNotifier<DateTime?>(null);
  bool get isSupported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<void> initialize(String? manualLanguage) async {
    if (!isSupported) return;
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'notificationOpened') _openDate(call.arguments);
    });
    final quotes = QuoteCatalog().quotes;
    final catalogs = {
      for (final language in ['es', 'en', 'fr'])
        language: {
          for (final quote in quotes)
            quote.date: QuoteTranslations.shareText(quote, language)
        }
    };
    await _channel.invokeMethod<void>('initialize', {
      'catalogs': jsonEncode(catalogs),
      'manualLanguage': manualLanguage,
    });
    _openDate(await _channel.invokeMethod<String>('consumeOpenedDate'));
  }

  void _openDate(Object? value) {
    if (value is! String) return;
    final date = DateTime.tryParse(value);
    if (date != null) openedDate.value = date;
  }

  Future<void> updateLanguage(String? manualLanguage) async {
    if (isSupported) {
      await _channel.invokeMethod<void>(
          'updateLanguage', {'manualLanguage': manualLanguage});
    }
  }

  Future<ReminderSettings> load() async {
    final data = await _channel.invokeMapMethod<Object?, Object?>('settings');
    return ReminderSettings.fromMap(data ?? {});
  }

  Future<bool> requestPermission() async =>
      await _channel.invokeMethod<bool>('requestPermission') ?? false;

  Future<bool> save(ReminderSettings settings) async =>
      await _channel.invokeMethod<bool>('configure', settings.toMap()) ?? false;

  Future<bool> preview() async =>
      await _channel.invokeMethod<bool>('preview') ?? false;

  Future<void> openSystemSettings() =>
      _channel.invokeMethod<void>('openSystemSettings');
}
