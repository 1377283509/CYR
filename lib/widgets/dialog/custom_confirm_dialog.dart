import 'package:flutter/material.dart';

class CustomConfirmDialog extends StatelessWidget {

  final String title;
  final String content;
  final String confirmLabel;
  final String cancelLabel;

  const CustomConfirmDialog({@required this.title, this.content, this.confirmLabel, this.cancelLabel,Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content??""),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      actions: [
        FlatButton(
          child: Text(confirmLabel??"确认"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text(cancelLabel??"取消", style: TextStyle(
            color: Colors.red
          ),),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
