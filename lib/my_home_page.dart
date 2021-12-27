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
  Quote quote = QuoteProvider().getQuoteByDay(
    monthsNames.elementAt(DateTime.now().month - 1) +
        ' ' +
        DateTime.now().day.toString(),
  );

  void _incrementCounter() {
    setState(() {
      quote = QuoteProvider().getQuoteRandom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SelectableText(
                quote.quote + '.',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 24,
                ),
                textAlign: TextAlign.justify,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    quote.author,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                child: const Icon(Icons.share_sharp),
                onPressed: () async {
                  await Share.share(quote.quote);
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Random',
        child: const Icon(Icons.share),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
