import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Center(
        child: Container(
          width: 28.0,
          height: 28.0,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
