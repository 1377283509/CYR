import 'package:cyr/widgets/buttons/normal_button.dart';
import 'package:cyr/widgets/form/text_input.dart';
import 'package:flutter/material.dart';

class SelectInputPage extends StatefulWidget {
  final List<String> values;
  final String title;
  SelectInputPage({@required this.title, this.values});

  @override
  _SelectInputPageState createState() => _SelectInputPageState();
}

class _SelectInputPageState extends State<SelectInputPage> {
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 选项
            _buildValues(),
            // 输入框
            _buildInput(),
            // 提交按钮
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildValues(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Wrap(
        spacing: 8,
        children: widget.values.map((e) => ActionChip(
          label: Text(e),
          backgroundColor: Colors.indigo.withOpacity(0.1),
          onPressed: (){
            List<String> values = _controller.text.split("、");
            if(!values.contains(e)){
              _controller.text += "$e、";
              setState(() {
              });
            }
          },
        )).toList(),
      ),
    );
  }

  Widget _buildInput(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InputTextArea(
        controller: _controller,
        label: "其它",
        placeHolder: "",
      ),
    );
  }

  Widget _buildButton(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 48),
      child: CustomButton(
        title: "提交",
        onTap: (){
          Navigator.pop(context, [_controller.text]);
        },
      ),
    );
  }


}
