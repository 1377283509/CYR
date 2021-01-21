import 'package:flutter/material.dart';

class BoolCard extends StatelessWidget {
  final bool state;
  final Function onTap;

  BoolCard({this.state,this.onTap});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: state
                ? Colors.green.withOpacity(0.6)
                : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(6)),
        child: Text(
          state ? "是" : "否",
          style: TextStyle(
              color:
              state ? Colors.white : Colors.black54),
        ),
      ),
    );
  }
}
