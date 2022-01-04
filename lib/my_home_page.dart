import 'dart:ui';

import 'package:date_field/date_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motivaciones_diarias/quote.dart';
import 'package:motivaciones_diarias/quote_provider.dart';
import 'package:share/share.dart';

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

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
        tooltip: 'Random',
        child: const Icon(Icons.account_balance_rounded),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildDateTimePiker() {
    if (_visibilityDatePicker) {
      return Container(
        margin: const EdgeInsets.all(20),
        child: DateTimeFormField(
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.black45),
            errorStyle: TextStyle(color: Colors.redAccent),
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.event_note),
            labelText: 'Frase del '
                'día',
          ),
          mode: DateTimeFieldPickerMode.date,
          autovalidateMode: AutovalidateMode.always,
          onDateSelected: (DateTime value) {
            if (kDebugMode) {
              print(value);
            }
            seeQuoteByDate(value);
          },
          onSaved: (value) => {
            setState(() {
              _quote = QuoteProvider().getQuoteByDay(
                monthsNames.elementAt(value!.month - 1) +
                    ' ' +
                    value.day.toString(),
              );
            })
          },
        ),
      );
    } else {
      return Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            _quote.date,
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
      title: Text(widget.title),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {},
          itemBuilder: (BuildContext contex) => <PopupMenuEntry>[
            PopupMenuItem(
              onTap: () {
                _getRandomQuote();
              },
              child: const ListTile(
                leading: Icon(Icons.account_balance_rounded),
                title: Text('Nueva frase'),
              ),
            ),
            PopupMenuItem(
              onTap: () async {
                await shareQuote();
              },
              child: const ListTile(
                leading: Icon(Icons.share),
                title: Text('Compartir frase'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                _setStateOfDateTime(true);
              },
              child: const ListTile(
                leading: Icon(Icons.search),
                title: Text('Buscar por fecha'),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Mas información'),
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
    final shareQuote = _quote.quote + '.\n      ' + _quote.author;
    if (kDebugMode) {
      print(shareQuote);
    }
    await Share.share(shareQuote);
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
            const Text('Version: 1.0.0'),
            const SizedBox(height: 10),
            const Text('Autor: Ing. Raydel Raúl Viñolo Sosa'),
            const SelectableText('Contacto: raydel8806dev@gmail.com'),
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
            _quote.quote + '.',
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
              _quote.author,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          ElevatedButton(
            child: const Icon(Icons.share_sharp, semanticLabel: 'Compartir'),
            onPressed: () async {
              await shareQuote();
            },
          ),
        ],
      ),
    );
  }
}
