import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String title;
  CardTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
        ));
  }
}
