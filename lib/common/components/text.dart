import 'package:flutter/material.dart';


class AppTitle extends StatelessWidget {
  final String value;
  static const textSize = 28.0;
  const AppTitle({super.key, required this.value});
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AppSubtitle extends StatelessWidget {
  final TextAlign? textAlign;
  final String value;
  static const textSize = 22.0;

  const AppSubtitle({super.key, required this.value, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.w600,
      ),
      textAlign: textAlign,
    );
  }
}

class AppText extends StatelessWidget {
  final String value;
  static const textSize = 18.0;

  const AppText({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
