import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {

  final double thickness;
  final Color color;
  final double height;
  final double indent;
  final double endIndent;

  const CustomDivider({this.height=4,this.color,this.endIndent=16,this.indent=16,this.thickness=1, Key key}):super(key: key);


  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color??Theme.of(context).primaryColor.withOpacity(0.1),
      thickness: thickness,
      height: height,
      indent: indent,
      endIndent: endIndent,
    );
  }
}