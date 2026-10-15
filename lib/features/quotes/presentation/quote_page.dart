import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motivaciones_diarias/features/quotes/models/quote.dart';
import 'package:motivaciones_diarias/features/quotes/data/quote_catalog.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/localization/app_strings.dart';
import '../../../shared/widgets/about_content.dart';
import '../data/quote_translations.dart';
import '../../favorites/data/favorites_store.dart';
import '../../favorites/presentation/favorites_page.dart';
import '../../reminders/data/daily_reminder_service.dart';
import '../../reminders/presentation/reminder_settings_page.dart';
import 'dart:async';
import '../../reading/data/quote_speaker.dart';

class QuotePage extends StatefulWidget {
  const QuotePage(
      {Key? key,
      required this.onLanguageChanged,
      required this.favoritesStore,
      this.reminderService,
      this.speaker,
      this.selectedLocale})
      : super(key: key);
  final ValueChanged<Locale?> onLanguageChanged;
  final Locale? selectedLocale;
  final FavoritesStore favoritesStore;
  final DailyReminderService? reminderService;
  final QuoteSpeaker? speaker;

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> with WidgetsBindingObserver {
  bool _datePickerVisible = false;

  final _catalog = QuoteCatalog();
  late Quote _quote;
  bool _savingFavorite = false;
  bool _showingToday = true;
  Timer? _midnightTimer;
  late final QuoteSpeaker _speaker;
  String? _speechLanguage;

  Future<void> _stopReading() async {
    try {
      await _speaker.stop();
    } catch (error) {
      debugPrint('Could not stop speech: $error');
    }
  }

  Future<void> _readQuote() async {
    if (_speaker.isActive) {
      await _stopReading();
      return;
    }
    final language = Localizations.localeOf(context).languageCode;
    try {
      final outcome = await _speaker.read(
          QuoteTranslations.shareText(_quote, language), language);
      if (mounted && outcome == SpeechOutcome.unavailable) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.of(context).voiceUnavailable)),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.of(context).speechError)),
        );
      }
    }
  }

  Future<void> _toggleFavorite() async {
    setState(() => _savingFavorite = true);
    try {
      await widget.favoritesStore.toggle(_quote);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.of(context).favoritesError)),
        );
      }
    }
    if (mounted) setState(() => _savingFavorite = false);
  }

  Future<void> _openFavorites() async {
    await _stopReading();
    if (!mounted) return;
    final selected = await Navigator.push<Quote>(
        context,
        MaterialPageRoute(
            builder: (_) => FavoritesPage(store: widget.favoritesStore)));
    if (selected != null && mounted) {
      setState(() {
        _quote = selected;
        _showingToday = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _quote = _catalog.forDate(DateTime.now());
    _speaker = widget.speaker ?? QuoteSpeaker();
    WidgetsBinding.instance.addObserver(this);
    final opened = widget.reminderService?.openedDate.value;
    if (opened != null) {
      _quote = _catalog.forDate(opened);
      _showingToday = false;
      widget.reminderService?.openedDate.value = null;
    }
    widget.reminderService?.openedDate.addListener(_handleNotificationOpen);
    _scheduleDayRefresh();
  }

  void _scheduleDayRefresh() {
    _midnightTimer?.cancel();
    final now = DateTime.now();
    final next = DateTime(now.year, now.month, now.day + 1);
    _midnightTimer = Timer(next.difference(now), () {
      if (!mounted) return;
      if (_showingToday) {
        _stopReading();
        setState(() => _quote = _catalog.forDate(DateTime.now()));
      }
      _scheduleDayRefresh();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final language = Localizations.localeOf(context).languageCode;
    if (_speechLanguage != null && _speechLanguage != language) {
      _stopReading();
    }
    _speechLanguage = language;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) _stopReading();
    if (state == AppLifecycleState.resumed) {
      if (_showingToday) {
        _stopReading();
        setState(() => _quote = _catalog.forDate(DateTime.now()));
      }
      _scheduleDayRefresh();
    }
  }

  void _handleNotificationOpen() {
    final date = widget.reminderService?.openedDate.value;
    if (date == null || !mounted) return;
    widget.reminderService?.openedDate.value = null;
    _stopReading();
    Navigator.of(context).popUntil((route) => route.isFirst);
    setState(() {
      _quote = _catalog.forDate(date);
      _showingToday = false;
    });
  }

  @override
  void dispose() {
    if (widget.speaker == null) {
      _speaker.dispose();
    } else {
      _stopReading();
    }
    _midnightTimer?.cancel();
    widget.reminderService?.openedDate.removeListener(_handleNotificationOpen);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _getRandomQuote() {
    _stopReading();
    setState(() {
      _quote = _catalog.randomQuote();
      _showingToday = false;
    });
  }

  void _setDatePickerVisible(bool visibilityDatePicker) {
    _stopReading();
    setState(() {
      _datePickerVisible = visibilityDatePicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight:
                      (constraints.maxHeight - 48).clamp(0, double.infinity)),
              child: Align(
                alignment: const Alignment(0, -0.3),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDatePickerOrLabel(),
                      const SizedBox(height: 24),
                      _buildBody(),
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        onPressed: _getRandomQuote,
                        icon: const Icon(Icons.shuffle_rounded),
                        label: Text(AppStrings.of(context).newQuote),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDatePickerOrLabel() {
    if (_datePickerVisible) {
      return Container(
        margin: const EdgeInsets.all(20),
        child: OutlinedButton.icon(
          icon: const Icon(Icons.event_note),
          label: Text(AppStrings.of(context).dailyQuote),
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100, 12, 31),
            );
            if (date != null && mounted) _selectDate(date);
          },
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined,
              size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Flexible(
              child: Text(
            AppStrings.of(context).date(_quote.date),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary),
          )),
        ],
      );
    }
  }

  void _selectDate(DateTime value) {
    _stopReading();
    setState(() {
      _datePickerVisible = false;
      _quote = _catalog.forDate(value);
      _showingToday = false;
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(AppStrings.of(context).title),
      actions: [
        IconButton(
          tooltip: AppStrings.of(context).favorites,
          icon: const Icon(Icons.favorite_border),
          onPressed: _openFavorites,
        ),
        PopupMenuButton<String>(
          tooltip: AppStrings.of(context).languageLabel,
          icon: const Icon(Icons.language),
          initialValue: widget.selectedLocale?.languageCode ?? 'system',
          onSelected: (language) => widget.onLanguageChanged(
              language == 'system' ? null : Locale(language)),
          itemBuilder: (_) => [
            PopupMenuItem(
              value: 'system',
              child: Text(AppStrings.of(context).deviceLanguage),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(value: 'es', child: Text('Español')),
            const PopupMenuItem(value: 'en', child: Text('English')),
            const PopupMenuItem(value: 'fr', child: Text('Français')),
          ],
        ),
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {},
          itemBuilder: (BuildContext contex) => <PopupMenuEntry>[
            if (widget.reminderService?.isSupported == true)
              PopupMenuItem(
                onTap: () => Future<void>.delayed(Duration.zero, () {
                  if (!mounted) return;
                  _stopReading();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ReminderSettingsPage(
                              service: widget.reminderService!)));
                }),
                child: ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  title: Text(AppStrings.of(context).dailyReminder),
                ),
              ),
            PopupMenuItem(
              onTap: () {
                _getRandomQuote();
              },
              child: ListTile(
                leading: const Icon(Icons.shuffle_rounded),
                title: Text(AppStrings.of(context).newQuote),
              ),
            ),
            PopupMenuItem(
              onTap: () async {
                await _shareQuote();
              },
              child: ListTile(
                leading: const Icon(Icons.share),
                title: Text(AppStrings.of(context).share),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                _setDatePickerVisible(true);
              },
              child: ListTile(
                leading: const Icon(Icons.search),
                title: Text(AppStrings.of(context).search),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(AppStrings.of(context).about),
                  onTap: () {
                    _showAbout(context);
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _shareQuote() async {
    final language = Localizations.localeOf(context).languageCode;
    final text = QuoteTranslations.shareText(_quote, language);
    if (kDebugMode) {
      print(text);
    }
    await SharePlus.instance.share(
      ShareParams(text: text),
    );
  }

  void _showAbout(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 0),
      () => showAboutDialog(
        context: context,
        children: const <Widget>[AboutContent()],
      ),
    );
  }

  Widget _buildBody() {
    final colors = Theme.of(context).colorScheme;
    return Container(
      key: const ValueKey('quote_card'),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.primary.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
              color: colors.primary.withValues(alpha: 0.05),
              blurRadius: 24,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.format_quote_rounded, size: 40, color: colors.primary),
          const SizedBox(height: 16),
          SelectableText(
            QuoteTranslations.displayText(
                _quote, Localizations.localeOf(context).languageCode),
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 26,
              height: 1.45,
              color: colors.onSurface,
            ),
            textAlign: TextAlign.start,
          ),
          Container(
            margin: const EdgeInsets.only(top: 24, bottom: 24),
            alignment: Alignment.centerRight,
            child: Text(
              QuoteTranslations.author(
                  _quote, Localizations.localeOf(context).languageCode),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          Divider(color: colors.primary.withValues(alpha: 0.12)),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 8,
              children: [
                if (_speaker.isSupported)
                  AnimatedBuilder(
                    animation: _speaker,
                    builder: (context, _) => IconButton(
                      key: const ValueKey('read_quote'),
                      tooltip: _speaker.isActive
                          ? AppStrings.of(context).stopReading
                          : AppStrings.of(context).readQuote,
                      icon: _speaker.status == SpeechStatus.preparing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : Icon(_speaker.isActive
                              ? Icons.stop_circle_outlined
                              : Icons.volume_up_outlined),
                      onPressed: _readQuote,
                    ),
                  ),
                AnimatedBuilder(
                  animation: widget.favoritesStore,
                  builder: (context, _) => IconButton(
                    key: const ValueKey('toggle_favorite'),
                    tooltip: widget.favoritesStore.contains(_quote)
                        ? AppStrings.of(context).removeFavorite
                        : AppStrings.of(context).addFavorite,
                    icon: Icon(widget.favoritesStore.contains(_quote)
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: _savingFavorite ? null : _toggleFavorite,
                  ),
                ),
                IconButton(
                  tooltip: AppStrings.of(context).share,
                  icon: const Icon(Icons.ios_share_rounded),
                  onPressed: _shareQuote,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
