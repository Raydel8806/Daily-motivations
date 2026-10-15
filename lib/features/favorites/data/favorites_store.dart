import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../quotes/data/quote_catalog.dart';
import '../../quotes/models/quote.dart';

class FavoritesStore extends ChangeNotifier {
  FavoritesStore({SharedPreferencesAsync? storage}) : _storage = storage;

  static const storageKey = 'favorite_quote_dates';
  SharedPreferencesAsync? _storage;
  final _catalog = QuoteCatalog();
  Set<String> _dates = {};
  bool _loaded = false;
  bool _disposed = false;
  Future<void> _pendingWrite = Future<void>.value();

  List<Quote> get quotes =>
      _dates.map(_catalog.findByKey).whereType<Quote>().toList(growable: false);

  bool contains(Quote quote) => _dates.contains(quote.date);

  Future<void> load() async {
    if (_loaded) return;
    _storage ??= SharedPreferencesAsync();
    final saved = await _storage!.getStringList(storageKey) ?? [];
    _dates = saved.where((date) => _catalog.findByKey(date) != null).toSet();
    _loaded = true;
    if (!_disposed) notifyListeners();
  }

  Future<void> toggle(Quote quote) {
    final write = _pendingWrite.then((_) async {
      await load();
      final updated = Set<String>.of(_dates);
      if (!updated.remove(quote.date)) updated.add(quote.date);
      await _storage!.setStringList(storageKey, updated.toList());
      _dates = updated;
      if (!_disposed) notifyListeners();
    });
    _pendingWrite = write.catchError((Object _) {});
    return write;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
