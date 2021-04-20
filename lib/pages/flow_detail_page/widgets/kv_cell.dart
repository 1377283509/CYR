import 'package:cyr/widgets/text/background_color_text.dart';
import 'package:flutter/material.dart';

class KVCell extends StatelessWidget {
  final TextStyle _textStyle = TextStyle(fontSize: 16);

  final String keyname;
  final String value;

  KVCell(this.keyname, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Text(
                keyname,
                style: _textStyle,
              ),
            ),
          ),
          Expanded(
              flex: 8,
              child: Container(
                alignment: Alignment.centerRight,
                child: ColorText(text: value, textStyle: _textStyle),
              )),
        ],
      ),
    );
  }
}
