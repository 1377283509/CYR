import 'package:flutter/material.dart';

class DoctorStatPage extends StatelessWidget {
  _appBar(BuildContext context){
    return AppBar(
      title: Text("工作人员统计", style: Theme.of(context).textTheme.headline1),
      actions: [
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(child: Text("统计"),),
    );
  }
}
