import 'package:flutter/material.dart';

// 处理结果
class ResultPage extends StatelessWidget {
  final bool state;
  final String content;

  ResultPage({this.state = true, this.content = "操作成功"});

  Widget _buildIcon(bool success) {
    return Container(
      margin:const  EdgeInsets.only(top: 72),
      padding:const  EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: success?Colors.green:Colors.red,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(success?Icons.done:Icons.close, size: 48, color: Colors.white,),
    );
  }

  Widget _buildText(String content) {
    return Container(
      margin:const EdgeInsets.only(top: 24),
      padding:const EdgeInsets.symmetric(horizontal: 24),
      child: Text(content, style:const TextStyle(
        color: Colors.black54,
        fontSize: 16
      ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("结果"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(state),
            _buildText(content),
            const SizedBox(height: 120,)
          ],
        ),
      ),
    );
  }
}
