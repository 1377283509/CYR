import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String errMsg;
  ErrorPage(this.errMsg);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发生错误了"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(errMsg??"无可展示的报错信息"),
        ),
      ),
    );
  }
}