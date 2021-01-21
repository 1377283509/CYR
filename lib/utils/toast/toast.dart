import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';


void showToast(String content, BuildContext context){
  Toast.show(content, context, gravity: Toast.CENTER, );
}