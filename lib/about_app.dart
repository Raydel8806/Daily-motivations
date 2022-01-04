import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Image.asset(
        'assets/img.png',
        alignment: Alignment.center,
        height: 100,
        width: 100,
      ),
      const SizedBox(height: 10),
      const Text('Version: 1.0.0'),
      const SizedBox(height: 10),
      const Text('Autor: Raydel Raúl Viñolo Sosa'),
    ]);
  }
}
