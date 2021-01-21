import 'package:cyr/widgets/buttons/normal_button.dart';
import 'package:cyr/widgets/form/text_input.dart';
import 'package:flutter/material.dart';

class SingleInputPage extends StatefulWidget {
  final String title;
  final int maxLength;
  final Function onSubmit;
  final String placeHolder;
  final String value;
  final TextInputType inputType;
  final bool isOneLine;

  SingleInputPage(
      {this.placeHolder = "在此输入内容",
        this.inputType = TextInputType.text,
        this.isOneLine = true,
      @required this.title,
      this.maxLength,
      this.onSubmit,
      this.value});

  @override
  _SingleInputPageState createState() => _SingleInputPageState();
}

class _SingleInputPageState extends State<SingleInputPage> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Container(
            padding:const  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.isOneLine?InputTextTile(
                  controller: _controller,
                  prefix:const  Icon(Icons.edit),
                  onSubmitted: widget.onSubmit,
                  placeHolder: widget.placeHolder,
                  label: widget.title,
                  autoFocus: true,
                  maxLength: widget.maxLength,
                  inputType: widget.inputType,
                  suffix: IconButton(
                    icon:const  Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                ):InputTextArea(controller: _controller, autoFocus: true,placeHolder: widget.placeHolder,),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                    onTap: () {
                      Navigator.of(context).pop([_controller.text]);
                    },
                    title: "提交"),
              ],
            ),
          ),
        ));
  }
}
