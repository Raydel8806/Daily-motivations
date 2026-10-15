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
  String get deviceLanguage =>
      _text('Idioma del teléfono', 'Device language', 'Langue du téléphone');
  String get languageSaveError => _text(
      'No se pudo guardar el idioma. Inténtalo de nuevo.',
      'Could not save the language. Please try again.',
      'Impossible d’enregistrer la langue. Veuillez réessayer.');
  String get author => _text('Autor', 'Author', 'Auteur');
  String get contact => _text('Contacto', 'Contact', 'Contact');
  String get version => _text('Versión', 'Version', 'Version');
  String get favorites => _text('Favoritos', 'Favorites', 'Favoris');
  String get addFavorite =>
      _text('Añadir a favoritos', 'Add to favorites', 'Ajouter aux favoris');
  String get removeFavorite => _text(
      'Quitar de favoritos', 'Remove from favorites', 'Retirer des favoris');
  String get noFavorites => _text(
      'Aún no tienes favoritos. Guarda una frase con el corazón.',
      'No favorites yet. Save a quote using the heart.',
      'Aucun favori pour le moment. Enregistrez une citation avec le cœur.');
  String get favoritesError => _text(
      'No se pudieron guardar o cargar los favoritos. Inténtalo de nuevo.',
      'Could not save or load favorites. Please try again.',
      'Impossible d’enregistrer ou de charger les favoris. Veuillez réessayer.');
  String get retry => _text('Reintentar', 'Retry', 'Réessayer');
  String get dailyReminder =>
      _text('Recordatorio diario', 'Daily reminder', 'Rappel quotidien');
  String get reminderDescription => _text(
      'Recibe la frase del día en tu teléfono.',
      'Receive the quote of the day on your phone.',
      'Recevez la citation du jour sur votre téléphone.');
  String get reminderTime =>
      _text('Hora del recordatorio', 'Reminder time', 'Heure du rappel');
  String get reminderTimingNote => _text(
      'El recordatorio usa la hora local del teléfono. Android puede retrasarlo para ahorrar batería.',
      'The reminder follows your phone’s local time. Android may delay it to save battery.',
      'Le rappel suit l’heure locale de votre téléphone. Android peut le retarder pour économiser la batterie.');
  String get testNotification => _text(
      'Probar notificación', 'Test notification', 'Tester la notification');
  String get systemNotificationSettings => _text(
      'Ajustes de notificaciones del teléfono',
      'Phone notification settings',
      'Paramètres de notification du téléphone');
  String get notificationPermissionDenied => _text(
      'Las notificaciones están desactivadas. Puedes permitirlas en los ajustes del teléfono.',
      'Notifications are disabled. You can allow them in your phone settings.',
      'Les notifications sont désactivées. Vous pouvez les autoriser dans les paramètres du téléphone.');
  String get reminderError => _text(
      'No se pudo configurar el recordatorio. Inténtalo de nuevo.',
      'Could not configure the reminder. Please try again.',
      'Impossible de configurer le rappel. Veuillez réessayer.');
  String get readQuote =>
      _text('Leer en voz alta', 'Read aloud', 'Lire à voix haute');
  String get stopReading =>
      _text('Detener lectura', 'Stop reading', 'Arrêter la lecture');
  String get voiceUnavailable => _text(
      'No hay una voz instalada para este idioma. Puedes añadirla en los ajustes de texto a voz del teléfono.',
      'No installed voice is available for this language. You can add one in your phone’s text-to-speech settings.',
      'Aucune voix installée n’est disponible pour cette langue. Vous pouvez en ajouter une dans les paramètres de synthèse vocale du téléphone.');
  String get speechError => _text(
      'No se pudo leer la frase. Inténtalo de nuevo.',
      'Could not read the quote. Please try again.',
      'Impossible de lire la citation. Veuillez réessayer.');

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
