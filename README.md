# Daily Motivations

A Flutter app with a motivational quote for every day of the year.

The reading screen uses a warm neutral background, a green accent, and a
centered card with readable, left-aligned type. Long quotes and large system
text sizes scroll naturally; the content width is capped on wider screens.
Playback, favorites, and sharing stay together beneath the author.

## Languages

The interface, calendar, dates, and all 366 quotes are available in Spanish,
English, and French. By default, the app uses the first supported language in
the device's preferred language list and falls back to English if none match.
Regional variants such as Canadian French and Mexican Spanish use the
corresponding supported language.

The language icon in the app bar lets users switch languages while keeping the
selected quote. Manual selections are stored locally and restored on restart.
Choose **Device language** to clear the override and follow the device again.
Automatic language detection does not save a manual override, so it can respond
to subsequent changes in the device's language settings.

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

`lib/core/localization/app_strings.dart` contains the interface text. Catalogs
use the original Spanish date as a stable identifier to preserve the link
between each quote and its day, including February 29.

## Favorites

Use the heart below a quote to add or remove it from favorites. The heart in
the app bar opens the saved list. Tap a saved quote to open it on the main
screen. Favorites are stored locally using stable calendar identifiers, so
changing languages preserves the same saved quotes. The list survives app
restarts and does not require a network connection.

## Read Aloud

Use the speaker below a quote to read the quote and its author in the selected
language. Tap again to stop. Playback stops when changing quotes or languages,
opening another screen, or leaving the app. Android requires an installed offline
text-to-speech voice for the chosen language; if none is available, the app asks
the user to install one through the phone's text-to-speech settings.

## Daily Reminders (Android)

Open **Daily reminder** from the overflow menu. Notifications are off by default.
Choose a local time, then enable the reminder and allow the Android notification
permission. **Test notification** posts today's quote immediately without
enabling the daily schedule. A shortcut opens Android's notification settings.

The native Android receiver selects the current day's quote from an offline
cache of all three catalogs. It uses one renewable alarm, so reminders continue
without a server, an open Flutter screen, or a finite queue of future quotes.
Opening a notification shows its quote on the main screen. The receiver
reschedules after a reboot, app update, clock change, or timezone change and
selects the appropriate language when delivering the notification.

These are battery-friendly inexact reminders: Android can delay delivery beyond
the chosen time. Force-stopping the app or device-specific background restrictions
can prevent delivery until the app is reopened. The current reminder integration
is Android-only; the option is hidden on other platforms.

Android unit tests cover calendar boundaries, leap day, and daylight-saving
changes. An instrumentation test verifies notification delivery directly from
the receiver without starting the Flutter activity, duplicate suppression, and
cancellation. Run on a test emulator: the instrumentation test grants
notification permission when needed and restores the saved reminder settings:

```sh
cd android
./gradlew :app:testDebugUnitTest :app:connectedDebugAndroidTest
```

Use the same Java 21 runtime configured for Flutter when invoking Gradle directly.
See [Android's alarm scheduling guidance](https://developer.android.com/develop/background-work/services/alarms)
for the operating system's timing behavior.

## Source Layout

```text
lib/
  main.dart                      # Startup and local preference loading
  app/app.dart                   # App theme, locale, and root navigation
  core/localization/             # Shared interface labels and date formatting
  features/
    quotes/
      models/                    # Immutable quote data
      data/                      # Calendar catalog and offline translations
      presentation/              # Quote screen and its interactions
    settings/data/               # Local language preference storage
    favorites/                   # Persistent saved quotes and their list
    reminders/                   # Android reminder settings and native bridge
    reading/data/                # Text-to-speech playback and voice selection
  shared/widgets/                # Reusable interface components
test/features/                   # Tests grouped by feature
```

This small app uses feature folders and separates storage and catalog logic
from interface code. Stateful widgets handle screen state. It does not require
a dependency injection container or a state management framework. New features
can add their own data and presentation files when needed.

## Development Commands

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

Tests verify coverage of all 366 dates in both translation catalogs, sharing
text, language switching, calendar localization, saved language restoration,
automatic device selection, English fallback, and storage error recovery.

`dart run tool/translate_quotes.dart` is a development importer that requires a
network connection and queries an external translation service. It preserves
existing entries, including manual corrections. The app does not use this
service at runtime.

`dart run tool/translate_quotes.dart --check` validates that all 366 dates match
both catalogs without network access or file changes.
