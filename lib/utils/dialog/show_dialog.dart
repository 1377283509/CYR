import 'package:cyr/widgets/dialog/alert_dialog.dart';
import 'package:cyr/widgets/dialog/custom_confirm_dialog.dart';
import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String content, [String title]){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return CustomAlertDialog(content, title: title,);
    }
  );
}

Future<bool> showConfirmDialog(BuildContext context, String title, {String content, String confirmLabel, String cancelLabel})async{
  var res = await showDialog(
    context: context,
    builder: (BuildContext context){
      return CustomConfirmDialog(title: title, content: content, confirmLabel: confirmLabel,cancelLabel: cancelLabel,);
    }
  );
  return res??false;
}