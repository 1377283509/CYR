
import 'package:flutter/material.dart';
class CustomAlertDialog extends StatelessWidget {
  final String content;
  final String title;
  CustomAlertDialog(this.content, {this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title??""),
      content: Text(content??""),
      actions: [
        TextButton(
          child: Text("确认"),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
