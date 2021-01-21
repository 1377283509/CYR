import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Function onRefresh;
  final Widget child;

  CustomRefreshIndicator({@required this.child,@required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: Theme.of(context).primaryColor,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
