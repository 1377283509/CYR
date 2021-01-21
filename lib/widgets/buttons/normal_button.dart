import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color backgroundColor;
  final Color textColor;
  final bool loading;

  CustomButton(
      {@required this.onTap,
      @required this.title,
      this.backgroundColor,
      this.textColor,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      child: FlatButton(
          child: loading?CircularProgressIndicator(

          ):Text(
            title,
            style: TextStyle(
                color: textColor ?? Colors.white,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          color: backgroundColor ?? Theme.of(context).primaryColor,
          splashColor: Colors.white54,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: onTap),
    );
  }
}
