import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

Future navigateTo(BuildContext context, Widget page) async {
  return await Navigator.push(
      context,
      PageTransition(
          child: page,
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 200)));
}

Future navigateReplacement(BuildContext context, Widget page) async {
  return await Navigator.pushReplacement(
      context,
      PageTransition(
          child: page,
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300)));
}
