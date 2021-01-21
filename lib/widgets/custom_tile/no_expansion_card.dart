// 普通卡片
import 'package:flutter/material.dart';

class NoExpansionCard extends StatelessWidget {
  final String title;
  final Widget trailing;
  final Function onTap;

  NoExpansionCard({this.title, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          onTap: () async {
            if(onTap != null){
              await onTap();
            }
          },
          title: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          trailing: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                trailing ??
                    SizedBox(
                      width: 0,
                    ),
                SizedBox(
                  width: 6,
                ),
                Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              ],
            ),
          ),
        ));
  }
}