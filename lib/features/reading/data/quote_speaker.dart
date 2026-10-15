import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum SpeechStatus { idle, preparing, speaking }

enum SpeechOutcome { finished, interrupted, unavailable }

class QuoteSpeaker extends ChangeNotifier {
  QuoteSpeaker({FlutterTts? engine}) : _engine = engine;
  FlutterTts? _engine;
  SpeechStatus _status = SpeechStatus.idle;
  int _request = 0;
  bool _disposed = false;

  SpeechStatus get status => _status;
  bool get isActive => _status != SpeechStatus.idle;
  bool get isSupported =>
      kIsWeb ||
      [
        TargetPlatform.android,
        TargetPlatform.iOS,
        TargetPlatform.macOS,
        TargetPlatform.windows
      ].contains(defaultTargetPlatform);

  void _setStatus(SpeechStatus status) {
    if (_disposed) return;
    _status = status;
    notifyListeners();
  }

  Future<SpeechOutcome> read(String text, String language) async {
    final request = ++_request;
    _setStatus(SpeechStatus.preparing);
    try {
      final engine = _engine ??= FlutterTts();
      await engine.stop();
      final rawVoices = await engine.getVoices;
      final voices = rawVoices is List
          ? rawVoices
              .whereType<Map>()
              .where((voice) =>
                  voice['name'] is String &&
                  voice['locale'] is String &&
                  (voice['locale'] as String)
                          .replaceAll('_', '-')
                          .split('-')
                          .first
                          .toLowerCase() ==
                      language)
              .toList()
          : <Map>[];
      final android =
          !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
      Map? selected;
      for (final voice in voices) {
        if (android) {
          final network = voice['network_required'];
          if (network == true ||
              network == 1 ||
              network == '1' ||
              network == 'true') {
            continue;
          }
          if (await engine.isLanguageInstalled(voice['locale'] as String) !=
              true) {
            continue;
          }
        }
        selected = voice;
        break;
      }
      if (_disposed || request != _request) return SpeechOutcome.interrupted;
      if (selected == null) {
        _setStatus(SpeechStatus.idle);
        return SpeechOutcome.unavailable;
      }
      final locale = (selected['locale'] as String).replaceAll('_', '-');
      final languageResult = await engine.setLanguage(locale);
      if (_disposed || request != _request) return SpeechOutcome.interrupted;
      if (languageResult != 1) {
        _setStatus(SpeechStatus.idle);
        return SpeechOutcome.unavailable;
      }
      await engine
          .setVoice({'name': selected['name'] as String, 'locale': locale});
      await engine.setSpeechRate(0.45);
      await engine.setVolume(1.0);
      await engine.setPitch(1.0);
      await engine.awaitSpeakCompletion(true);
      if (_disposed || request != _request) return SpeechOutcome.interrupted;
      _setStatus(SpeechStatus.speaking);
      final result = await engine.speak(text, focus: android);
      if (_disposed || request != _request) return SpeechOutcome.interrupted;
      _setStatus(SpeechStatus.idle);
      if (result != 1) {
        throw StateError('The speech engine rejected the utterance');
      }
      return SpeechOutcome.finished;
    } catch (_) {
      if (_disposed || request != _request) return SpeechOutcome.interrupted;
      _setStatus(SpeechStatus.idle);
      rethrow;
    }
  }

  Future<void> stop() async {
    ++_request;
    _setStatus(SpeechStatus.idle);
    await _engine?.stop();
  }

  @override
  void dispose() {
    ++_request;
    _disposed = true;
    _engine?.stop().catchError((Object error) {
      debugPrint('Could not stop speech during disposal: $error');
      return 0;
    });
    super.dispose();
  }
}
