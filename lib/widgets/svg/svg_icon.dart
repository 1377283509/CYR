import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetName;
  final double width;
  final double height;

  SvgIcon({this.assetName, this.width, this.height, Key key}):super(key: key);


  @override
  Widget build(BuildContext context) {
    return  SvgPicture.asset(
      assetName, width: width,height: height,
    );
  }
}
