import 'package:cyr/models/model_list.dart';
import 'package:flutter/material.dart';

class IDCardWidget extends StatelessWidget {
  final IDCard idCard;
  IDCardWidget(this.idCard);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8, left: 12, right: 12),
        decoration: BoxDecoration(color: Colors.indigo.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              isThreeLine: true,
              title: Text.rich(TextSpan(
                  text: idCard.name,
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  children: [
                    TextSpan(
                        text: "\b\b\b\b${idCard.gender}\b\b${idCard.age}岁",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                            fontSize: 14))
                  ])),
              subtitle: Text(
                "身份证号：${idCard.id} \n家庭住址：${idCard.address}",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ));
  }
}
