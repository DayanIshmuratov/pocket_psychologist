import 'package:flutter/material.dart';


class AppTitle extends StatelessWidget {
  final String value;
  final Color? color;
  static const textSize = 28.0;
  const AppTitle({super.key, required this.value, this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        color: color,
        fontSize: textSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AppSubtitle extends StatelessWidget {
  final TextAlign? textAlign;
  final int? maxLines;
  final Color? color;
  final String value;
  static const textSize = 22.0;

  const AppSubtitle({super.key, required this.value, this.textAlign, this.color, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        color: color,
        fontSize: textSize,
        fontWeight: FontWeight.w600,
      ),
      textAlign: textAlign,
      maxLines: maxLines,

    );
  }
}

class AppText extends StatelessWidget {
  final TextAlign? textAlign;
  final int? maxLines;
  final Color? color;
  final String value;
  static const textSize = 18.0;

  const AppText({super.key, required this.value, this.textAlign, this.color, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style:  TextStyle(
        color: color,
        fontSize: textSize,
        fontWeight: FontWeight.w600,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
