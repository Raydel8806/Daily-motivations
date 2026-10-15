# Daily Motivations

A Flutter app with a motivational quote for every day of the year.

## Languages

The interface, calendar, dates, and all 366 quotes are available in Spanish,
English, and French. The app starts in the device language and falls back to
Spanish for unsupported languages. The language icon in the app bar lets users
switch languages during a session while keeping the selected quote. A manual
language selection resets when the app restarts.

Quote translations are bundled in `assets/quotes_en.json` and
`assets/quotes_fr.json`. Reading and sharing quotes does not require a network
connection. The translations were initially generated automatically, then all
366 entries were reviewed in Spanish, English, and French with AI assistance
for meaning, agreement, fluency, forms of address, and punctuation. Author name
spellings were corrected, and conventional localized forms were added where
appropriate.

The full change record is in `docs/linguistic_review.json`. The review criteria
and scope are described in `docs/linguistic_review.md`. This review is neither
certification by a human translator nor historical verification of every quote
and its attribution.

`lib/app_strings.dart` contains the interface text. Catalogs use the original
Spanish date as a stable identifier to preserve the link between each quote and
its day, including February 29.

## Development

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

Tests verify coverage of all 366 dates in both translation catalogs, sharing
text, language switching, and calendar localization.

`dart run tool/translate_quotes.dart` is a development importer that requires a
network connection and queries an external translation service. It preserves
existing entries, including manual corrections. The app does not use this
service at runtime.

`dart run tool/translate_quotes.dart --check` validates that all 366 dates match
both catalogs without network access or file changes.
