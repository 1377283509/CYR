// 状态icon
import 'package:flutter/material.dart';

import 'round_icon.dart';

class StateIcon extends StatelessWidget {
  final bool state;
  StateIcon(this.state);
  @override
  Widget build(BuildContext context) {
    return state
        ? RoundIcon(Icons.done, Colors.green[500])
        : RoundIcon(Icons.graphic_eq, Colors.red);
  }
}