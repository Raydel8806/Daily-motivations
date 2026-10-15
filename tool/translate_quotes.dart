import 'dart:convert';
import 'dart:io';

// Development-only importer. The application uses the resulting offline data.
Future<void> main(List<String> arguments) async {
  final source =
      File('lib/features/quotes/data/quote_catalog.dart').readAsStringSync();
  final strings = RegExp(
      r'''\x27((?:\\.|[^\x27\\])*)\x27|"((?:\\.|[^"\\])*)"|,''',
      dotAll: true);
  final entries = <List<String>>[];
  for (final match
      in RegExp(r'\bQuote\((.*?)\)', dotAll: true).allMatches(source)) {
    final fields = <String>[''];
    for (final token in strings.allMatches(match.group(1)!)) {
      if (token.group(0) == ',') {
        fields.add('');
      } else {
        fields[fields.length - 1] += token.group(2) != null
            ? jsonDecode(token.group(0)!) as String
            : token.group(1)!.replaceAll(r"\'", "'");
      }
    }
    if (fields.length != 3) {
      throw StateError('Invalid quote: ${match.group(0)}');
    }
    entries.add(fields);
  }
  if (entries.length != 366) {
    throw StateError('Expected 366 quotes, got ${entries.length}');
  }
  if (arguments.contains('--check')) {
    final dates = entries.map((entry) => entry.first).toSet();
    for (final language in ['en', 'fr']) {
      final data =
          jsonDecode(File('assets/quotes_$language.json').readAsStringSync())
              as Map;
      if (data.length != dates.length ||
          !data.keys.every(dates.contains) ||
          !data.values
              .every((value) => value is String && value.trim().isNotEmpty)) {
        throw StateError('Incomplete $language catalog');
      }
    }
    stdout.writeln('Validated 366 dates in both offline catalogs.');
    return;
  }
  final client = HttpClient();
  for (final language in ['en', 'fr']) {
    final file = File('assets/quotes_$language.json');
    final translated = file.existsSync()
        ? Map<String, dynamic>.from(jsonDecode(file.readAsStringSync()) as Map)
        : <String, dynamic>{};
    var next = 0;
    Future<void> worker() async {
      while (next < entries.length) {
        final entry = entries[next++];
        if (translated.containsKey(entry[0])) continue;
        for (var attempt = 0; attempt < 5; attempt++) {
          try {
            final uri =
                Uri.https('translate.googleapis.com', '/translate_a/single', {
              'client': 'gtx',
              'sl': 'es',
              'tl': language,
              'dt': 't',
              'q': entry[1],
            });
            final request = await client.getUrl(uri);
            final response = await request.close();
            final body = await utf8.decoder.bind(response).join();
            if (response.statusCode != 200) {
              throw HttpException('HTTP ${response.statusCode}');
            }
            final result = jsonDecode(body) as List;
            final text = (result.first as List)
                .map((part) => (part as List).first as String)
                .join()
                .trim();
            if (text.isEmpty) throw StateError('Empty translation');
            translated[entry[0]] = text;
            file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert({
              for (final e in entries)
                if (translated.containsKey(e[0])) e[0]: translated[e[0]]
            }));
            if (translated.length % 25 == 0) {
              stdout.writeln('$language: ${translated.length}/366');
            }
            break;
          } catch (error) {
            if (attempt == 4) rethrow;
            await Future<void>.delayed(Duration(seconds: 2 * (attempt + 1)));
          }
        }
      }
    }

    await Future.wait(List.generate(4, (_) => worker()));
    stdout.writeln('$language: complete (${translated.length})');
  }
  client.close();
}
