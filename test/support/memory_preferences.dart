import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoryPreferencesState {
  Completer<void>? writeGate;
  bool failWrites = false;
}

class MemoryPreferences extends Fake implements SharedPreferencesAsync {
  final Map<String, Object> values = {};
  final _state = MemoryPreferencesState();
  Completer<void>? get writeGate => _state.writeGate;
  set writeGate(Completer<void>? value) => _state.writeGate = value;
  bool get failWrites => _state.failWrites;
  set failWrites(bool value) => _state.failWrites = value;

  @override
  Future<String?> getString(String key) async => values[key] as String?;

  @override
  Future<List<String>?> getStringList(String key) async {
    final list = values[key] as List<String>?;
    return list == null ? null : List.of(list);
  }

  @override
  Future<void> setString(String key, String value) async {
    if (failWrites) throw StateError('Storage unavailable');
    await writeGate?.future;
    values[key] = value;
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    if (failWrites) throw StateError('Storage unavailable');
    await writeGate?.future;
    values[key] = List.of(value);
  }

  @override
  Future<void> remove(String key) async {
    if (failWrites) throw StateError('Storage unavailable');
    values.remove(key);
  }
}
