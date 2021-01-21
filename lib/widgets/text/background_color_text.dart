import 'package:flutter/material.dart';

class ColorText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color backgroundColor;

  const ColorText(
      {@required this.text,
      this.textStyle,
      this.backgroundColor = Colors.indigo,
      Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(color: backgroundColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(text??"", style: textStyle??TextStyle(
        color: backgroundColor,
        fontSize: 14
      ),),
    );
  }
}
