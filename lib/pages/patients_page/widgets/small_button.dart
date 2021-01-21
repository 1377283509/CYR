// 详情
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String label;
  SmallButton({this.label="详情"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: TextStyle(
                fontSize: 14,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),),
            Icon(Icons.keyboard_arrow_right, color: Colors.grey,)
          ],
        ),
        onPressed: (){},
      ),
    );
  }
}