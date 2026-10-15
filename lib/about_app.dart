import 'package:flutter/material.dart';
import 'app_strings.dart';

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
      Text('${AppStrings.of(context).version}: 1.0.0'),
      const SizedBox(height: 10),
      Text('${AppStrings.of(context).author}: Raydel Raúl Viñolo Sosa'),
    ]);
  }
}
