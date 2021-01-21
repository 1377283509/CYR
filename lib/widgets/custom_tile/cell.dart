import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const Cell(
      {@required this.title,
      @required this.color,
      @required this.icon,
      this.backgroundColor = Colors.white,
      this.textColor = Colors.black54,
      this.iconColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
          leading: Icon(
            icon,
            color: color,
            size: 32,
          ),
          title: Text(
            title,
            style: TextStyle(
                color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          )),
    );
  }
}
