// 可展开卡片
import 'package:flutter/material.dart';

class ExpansionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  ExpansionCard({@required this.title, @required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ExpansionTile(
          initiallyExpanded: false,
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.indigo, fontWeight: FontWeight.bold),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.end,
          children: children ?? [],
        ));
  }
}