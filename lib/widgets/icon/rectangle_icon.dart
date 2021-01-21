import 'package:flutter/material.dart';

class RectangleIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final int messageCount;

  RectangleIcon(
      {@required this.icon,
        this.backgroundColor,
        this.iconColor,
        this.iconSize,
        this.messageCount,
        Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: backgroundColor ??
              Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: Icon(
        icon,
        color: iconColor ?? Theme.of(context).primaryColor,
        size: iconSize ?? 24.0,
      ),
    );
  }
}