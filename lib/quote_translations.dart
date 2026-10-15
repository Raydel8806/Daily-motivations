import 'dart:convert';
import 'package:flutter/services.dart';
import 'quote.dart';

class QuoteTranslations {
  static final Map<String, Map<String, String>> _catalogs = {};

  static Future<void> load() async {
    for (final language in ['en', 'fr']) {
      final data = await rootBundle.loadString('assets/quotes_$language.json');
      _catalogs[language] = Map<String, String>.from(jsonDecode(data) as Map);
    }
  }

  static String text(Quote quote, String language) => language == 'es'
      ? quote.quote
      : _catalogs[language]?[quote.date] ?? quote.quote;

  static String displayText(Quote quote, String language) {
    final value = text(quote, language).trim();
    return RegExp(r'[.!?…]$').hasMatch(value) ? value : '$value.';
  }

  static String shareText(Quote quote, String language) =>
      '${displayText(quote, language)}\n${author(quote, language)}';

  static String author(Quote quote, String language) {
    const names = {
      'Anónimo': {'en': 'Anonymous', 'fr': 'Anonyme'},
      'Proverbio chino': {'en': 'Chinese proverb', 'fr': 'Proverbe chinois'},
      'Proverbio japonés': {
        'en': 'Japanese proverb',
        'fr': 'Proverbe japonais'
      },
      'Coronel Sanders': {'en': 'Colonel Sanders', 'fr': 'Colonel Sanders'},
      'Confucio': {'en': 'Confucius', 'fr': 'Confucius'},
      'Epicteto': {'en': 'Epictetus', 'fr': 'Épictète'},
      'Napoleón': {'en': 'Napoleon', 'fr': 'Napoléon'},
      'Aristóteles': {'en': 'Aristotle', 'fr': 'Aristote'},
      'Séneca': {'en': 'Seneca', 'fr': 'Sénèque'},
      'Lucio Anneo Séneca': {
        'en': 'Lucius Annaeus Seneca',
        'fr': 'Lucius Annaeus Sénèque'
      },
      'Cristóbal Colón': {
        'en': 'Christopher Columbus',
        'fr': 'Christophe Colomb'
      },
      'Lao-Tsé': {'en': 'Lao Tzu', 'fr': 'Lao Tseu'},
      'Tolstoi': {'en': 'Leo Tolstoy', 'fr': 'Léon Tolstoï'},
      'Víctor Hugo': {'en': 'Victor Hugo', 'fr': 'Victor Hugo'},
    };
    return names[quote.author]?[language] ?? quote.author;
  }
}
