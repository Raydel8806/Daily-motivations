import 'package:flutter/material.dart';

class AppStrings {
  AppStrings(this.language);
  final String language;

  static AppStrings of(BuildContext context) =>
      AppStrings(Localizations.localeOf(context).languageCode);

  String get title => _text(
      'Motivaciones Diarias', 'Daily Motivations', 'Motivations quotidiennes');
  String get newQuote => _text('Nueva frase', 'New quote', 'Nouvelle citation');
  String get share =>
      _text('Compartir frase', 'Share quote', 'Partager la citation');
  String get search =>
      _text('Buscar por fecha', 'Search by date', 'Rechercher par date');
  String get about => _text('Más información', 'About', 'À propos');
  String get dailyQuote =>
      _text('Frase del día', 'Quote of the day', 'Citation du jour');
  String get random =>
      _text('Frase aleatoria', 'Random quote', 'Citation aléatoire');
  String get languageLabel => _text('Idioma', 'Language', 'Langue');
  String get author => _text('Autor', 'Author', 'Auteur');
  String get contact => _text('Contacto', 'Contact', 'Contact');
  String get version => _text('Versión', 'Version', 'Version');

  String _text(String es, String en, String fr) => language == 'en'
      ? en
      : language == 'fr'
          ? fr
          : es;

  String date(String spanishDate) {
    const es = [
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
    const en = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    const fr = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre'
    ];
    final parts = spanishDate.split(' ');
    final month = es.indexOf(parts.first);
    if (month < 0 || parts.length != 2) return spanishDate;
    if (language == 'en') return '${en[month]} ${parts.last}';
    if (language == 'fr') return '${parts.last} ${fr[month]}';
    return '${parts.last} de ${es[month].toLowerCase()}';
  }
}
