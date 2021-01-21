import 'package:flutter/material.dart';

import '../widget_list.dart';

class SingleInputDialog extends StatefulWidget {
  final String label;
  final String placeHolder;
  final TextInputType inputTupe;

  SingleInputDialog({this.label="",this.placeHolder="", this.inputTupe=TextInputType.text});


  @override
  _SingleInputDialogState createState() => _SingleInputDialogState();
}

class _SingleInputDialogState extends State<SingleInputDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text(widget.label, style: TextStyle(
            fontSize: 16,
            color: Colors.black
        ),),
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      children: [
        InputTextTile(controller: _controller, label: "点击输入", placeHolder: widget.placeHolder, autoFocus: true, inputType: widget.inputTupe,),
        SizedBox(height: 12,),
        CustomButton(onTap: (){
          Navigator.pop(context, [_controller.text]);
        }, title: "确认"),
      ],
    );
  }
}
