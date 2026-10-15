import 'package:flutter/material.dart';
import '../../core/localization/app_strings.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({Key? key}) : super(key: key);

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
      Text('${AppStrings.of(context).author}: Ing. Raydel Raúl Viñolo Sosa'),
      SelectableText(
          '${AppStrings.of(context).contact}: raydel8806dev@gmail.com'),
    ]);
  }
}
