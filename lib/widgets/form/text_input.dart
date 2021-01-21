import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextTile extends StatefulWidget {
  final TextEditingController controller;
  final Widget prefix;
  final Widget suffix;
  final String placeHolder;
  final String label;
  final int maxLength;
  final Function onSubmitted;
  final Function onChanged;
  final TextInputType inputType;
  final bool autoFocus;

  InputTextTile(
      {@required this.controller,
      this.suffix,
      this.prefix,
      this.placeHolder = "",
      this.label = "",
      this.maxLength,
      this.autoFocus = false,
      this.inputType = TextInputType.text,
      this.onSubmitted,
      this.onChanged});

  @override
  _InputTextTileState createState() => _InputTextTileState();
}

class _InputTextTileState extends State<InputTextTile> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autoFocus,
      maxLines: 1,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        labelText: widget.label,
        labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            color: Colors.grey),
        isDense: true,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        helperMaxLines: 1,
        hintText: widget.placeHolder,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        prefixIcon: widget.prefix ?? Icon(Icons.edit),
        suffixIcon: widget.suffix ?? SizedBox(),
      ),
      controller: widget.controller,
      keyboardType: widget.inputType,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.none,
      toolbarOptions:
          ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
      cursorWidth: 3,
      cursorColor: Colors.indigo,
      cursorHeight: 22,
      cursorRadius: Radius.circular(5),
      showCursor: true,
      maxLength: widget.maxLength,
      onSubmitted: (v) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted(v);
        }
      },
      buildCounter: (BuildContext context,
          {int currentLength, bool isFocused, int maxLength}) {
        return isFocused
            ? Text(
                "内容长度：$currentLength",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            : Container(); //字符统计
      },
    );
  }
}

class InputTextArea extends StatefulWidget {
  final TextEditingController controller;
  final String placeHolder;
  final String label;
  final bool autoFocus;

  InputTextArea(
      {@required this.controller,
      this.placeHolder = "",
      this.label = "",
      this.autoFocus = false,});

  @override
  _InputTextAreaState createState() => _InputTextAreaState();
}

class _InputTextAreaState extends State<InputTextArea> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autoFocus,
      maxLines: null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        labelText: widget.label,
        labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            color: Colors.grey),
        isDense: true,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        helperMaxLines: 1,
        hintText: widget.placeHolder,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
      ),
      controller: widget.controller,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.none,
      textCapitalization: TextCapitalization.none,
      toolbarOptions:
          ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
      cursorWidth: 3,
      cursorColor: Colors.indigo,
      cursorHeight: 22,
      cursorRadius: Radius.circular(5),
      showCursor: true,
      buildCounter: (BuildContext context,
          {int currentLength, bool isFocused, int maxLength}) {
        return isFocused
            ? Text(
                "内容长度：$currentLength",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            : Container(); //字符统计
      },
    );
  }
}
