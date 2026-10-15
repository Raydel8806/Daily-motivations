import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motivaciones_diarias/quote.dart';
import 'package:motivaciones_diarias/quote_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'app_strings.dart';
import 'quote_translations.dart';

const List<String> monthsNames = [
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.onLanguageChanged})
      : super(key: key);
  final ValueChanged<Locale> onLanguageChanged;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _visibilityDatePicker = false;

  Quote _quote = QuoteProvider().getQuoteByDay(
    monthsNames.elementAt(DateTime.now().month - 1) +
        ' ' +
        DateTime.now().day.toString(),
  );

  void _getRandomQuote() {
    setState(() {
      _quote = QuoteProvider().getQuoteRandom();
    });
  }

  void _setStateOfDateTime(bool visibilityDatePicker) {
    setState(() {
      _visibilityDatePicker = visibilityDatePicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBody(),
          ],
        )),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _getRandomQuote,
        tooltip: AppStrings.of(context).random,
        child: const Icon(Icons.account_balance_rounded),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildDateTimePiker() {
    if (_visibilityDatePicker) {
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
            if (date != null && mounted) seeQuoteByDate(date);
          },
        ),
      );
    } else {
      return Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            AppStrings.of(context).date(_quote.date),
            style: const TextStyle(fontSize: 20),
          ));
    }
  }

  void seeQuoteByDate(DateTime value) {
    _visibilityDatePicker = false;
    super.setState(() {
      _quote = QuoteProvider().getQuoteByDay(
        monthsNames.elementAt(value.month - 1) + ' ' + value.day.toString(),
      );
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(AppStrings.of(context).title),
      actions: [
        PopupMenuButton<String>(
          tooltip: AppStrings.of(context).languageLabel,
          icon: const Icon(Icons.language),
          initialValue: Localizations.localeOf(context).languageCode,
          onSelected: (language) => widget.onLanguageChanged(Locale(language)),
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'es', child: Text('Español')),
            PopupMenuItem(value: 'en', child: Text('English')),
            PopupMenuItem(value: 'fr', child: Text('Français')),
          ],
        ),
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {},
          itemBuilder: (BuildContext contex) => <PopupMenuEntry>[
            PopupMenuItem(
              onTap: () {
                _getRandomQuote();
              },
              child: ListTile(
                leading: const Icon(Icons.account_balance_rounded),
                title: Text(AppStrings.of(context).newQuote),
              ),
            ),
            PopupMenuItem(
              onTap: () async {
                await shareQuote();
              },
              child: ListTile(
                leading: const Icon(Icons.share),
                title: Text(AppStrings.of(context).share),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                _setStateOfDateTime(true);
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
                    aboutInfo(context);
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> shareQuote() async {
    final language = Localizations.localeOf(context).languageCode;
    final shareQuote = QuoteTranslations.shareText(_quote, language);
    if (kDebugMode) {
      print(shareQuote);
    }
    await SharePlus.instance.share(
      ShareParams(text: shareQuote),
    );
  }

  void aboutInfo(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 0),
      () => showAboutDialog(
        context: context,
        children: <Widget>[
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(
              'assets/img.png',
              alignment: Alignment.center,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 10),
            Text('${AppStrings.of(context).version}: 1.0.0'),
            const SizedBox(height: 10),
            Text(
                '${AppStrings.of(context).author}: Ing. Raydel Raúl Viñolo Sosa'),
            SelectableText(
                '${AppStrings.of(context).contact}: raydel8806dev@gmail.com'),
          ])
        ],
      ),
    );
  }

  Container buildBody() {
    return Container(
      margin: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          buildDateTimePiker(),
          SelectableText(
            QuoteTranslations.displayText(
                _quote, Localizations.localeOf(context).languageCode),
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 24,
            ),
            textAlign: TextAlign.justify,
          ),
          Container(
            margin: const EdgeInsets.all(20),
            alignment: AlignmentGeometry.lerp(
                Alignment.bottomCenter, Alignment.bottomRight, 1),
            child: Text(
              QuoteTranslations.author(
                  _quote, Localizations.localeOf(context).languageCode),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          ElevatedButton(
            child: Icon(Icons.share_sharp,
                semanticLabel: AppStrings.of(context).share),
            onPressed: () async {
              await shareQuote();
            },
          ),
        ],
      ),
    );
  }
}
