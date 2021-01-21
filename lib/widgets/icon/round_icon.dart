// 圆形带背景色的icon
import 'package:flutter/material.dart';

class RoundIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;

  RoundIcon(this.icon, this.backgroundColor);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(50)),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ));
  }
}