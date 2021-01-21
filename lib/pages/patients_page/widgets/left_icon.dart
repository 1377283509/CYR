import 'package:flutter/material.dart';

class LeftIcon extends StatelessWidget {
  final Widget widget;
  LeftIcon(this.widget);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 5,
            decoration: BoxDecoration(
              color: Colors.white38,
            ),
          ),
          Center(
            child: widget,
          )
        ],
      ),
    );
  }
}
