import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../quotes/data/quote_translations.dart';
import '../data/favorites_store.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key, required this.store}) : super(key: key);
  final FavoritesStore store;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool _loading = true;
  bool _loadFailed = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadFailed = false;
    });
    try {
      await widget.store.load();
    } catch (_) {
      _loadFailed = true;
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final language = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(title: Text(strings.favorites)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _loadFailed
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(strings.favoritesError),
                      TextButton(onPressed: _load, child: Text(strings.retry)),
                    ],
                  ),
                )
              : AnimatedBuilder(
                  animation: widget.store,
                  builder: (context, _) {
                    final quotes = widget.store.quotes;
                    if (quotes.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(strings.noFavorites,
                              textAlign: TextAlign.center),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemCount: quotes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final quote = quotes[index];
                        return Material(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                            clipBehavior: Clip.antiAlias,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              title: Text(
                                  QuoteTranslations.displayText(
                                      quote, language),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis),
                              subtitle: Text(
                                  '${QuoteTranslations.author(quote, language)}\n${strings.date(quote.date)}'),
                              isThreeLine: true,
                              onTap: () => Navigator.pop(context, quote),
                              trailing: IconButton(
                                tooltip: strings.removeFavorite,
                                icon: const Icon(Icons.favorite),
                                onPressed: _saving
                                    ? null
                                    : () async {
                                        setState(() => _saving = true);
                                        try {
                                          await widget.store.toggle(quote);
                                        } catch (_) {
                                          if (mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      strings.favoritesError)),
                                            );
                                          }
                                        }
                                        if (mounted) {
                                          setState(() => _saving = false);
                                        }
                                      },
                              ),
                            ));
                      },
                    );
                  },
                ),
    );
  }
}
