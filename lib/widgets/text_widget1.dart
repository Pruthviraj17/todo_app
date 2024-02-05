import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  TextWidget({
    super.key,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
    this.lineThrough = false,
    this.fontColor,
  });

  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final bool lineThrough;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: fontColor ?? Theme.of(context).colorScheme.onBackground,
        fontWeight: fontWeight,
        fontSize: fontSize,
        decoration: lineThrough ? TextDecoration.lineThrough : null,
      ),
      textAlign: TextAlign.center,
    );
  }
}
