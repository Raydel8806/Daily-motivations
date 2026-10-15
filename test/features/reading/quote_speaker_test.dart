import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motivaciones_diarias/features/reading/data/quote_speaker.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('flutter_tts');
  final calls = <MethodCall>[];
  var installed = true;
  Completer<int>? utterance;
  setUp(() {
    calls.clear();
    installed = true;
    utterance = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      switch (call.method) {
        case 'getVoices':
          return [
            {'name': 'English', 'locale': 'en-US', 'network_required': '0'},
            {
              'name': 'French online',
              'locale': 'fr-FR',
              'network_required': '1'
            },
            {
              'name': 'French offline',
              'locale': 'fr-FR',
              'network_required': '0'
            },
          ];
        case 'isLanguageInstalled':
          return installed;
        case 'speak':
          return utterance == null ? 1 : utterance!.future;
        default:
          return 1;
      }
    });
  });
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('Reads with an installed offline voice in the selected language',
      () async {
    final speaker = QuoteSpeaker();
    expect(await speaker.read('Bonjour', 'fr'), SpeechOutcome.finished);
    expect(calls.firstWhere((c) => c.method == 'setVoice').arguments,
        {'name': 'French offline', 'locale': 'fr-FR'});
    expect(speaker.status, SpeechStatus.idle);
    await speaker.stop();
    speaker.dispose();
  });

  test('Missing voice never reads with a different language', () async {
    final speaker = QuoteSpeaker();
    installed = false;
    expect(await speaker.read('Bonjour', 'fr'), SpeechOutcome.unavailable);
    expect(await speaker.read('Hola', 'es'), SpeechOutcome.unavailable);
    expect(calls.where((c) => c.method == 'speak'), isEmpty);
    speaker.dispose();
  });

  test('Stopping prevents a late completion from restoring speech state',
      () async {
    final speaker = QuoteSpeaker();
    utterance = Completer<int>();
    final speaking = Completer<void>();
    speaker.addListener(() {
      if (speaker.status == SpeechStatus.speaking && !speaking.isCompleted) {
        speaking.complete();
      }
    });
    final reading = speaker.read('Hello', 'en');
    await speaking.future;
    await speaker.stop();
    utterance!.complete(0);
    expect(await reading, SpeechOutcome.interrupted);
    expect(speaker.status, SpeechStatus.idle);
    utterance = null;
    expect(await speaker.read('Hello again', 'en'), SpeechOutcome.finished);
    speaker.dispose();
  });
}
