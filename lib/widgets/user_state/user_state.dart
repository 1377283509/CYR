import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cyr/providers/provider_list.dart';
import '../widget_list.dart';
import 'dart:math' as math;


class StateCard extends StatefulWidget {
  @override
  _StateCardState createState() => _StateCardState();
}

class _StateCardState extends State<StateCard> {
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(
      builder: (_, userProvider, __) {
        bool state = userProvider.user == null?false:userProvider.user.state;
        return Padding(
            padding:const EdgeInsets.only(left: 12, right: 12, top: 24, bottom: 12),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 48,
                  color: Colors.white.withOpacity(0.36),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 左侧widget
                      state
                          ? _buildDragTarget(Icons.local_cafe)
                          : _buildDraggable(context, Icons.local_cafe, Colors.red, userProvider.changeState),
                      // 中间动画
                      _buildCenter(state),
                      // 右侧widget
                      state
                          ? _buildDraggable(context, Icons.local_hospital,Colors.green,userProvider.changeState)
                          : _buildDragTarget(Icons.local_hospital)
                    ],
                  ),
                )));
      },
    );
  }

  Widget _buildDraggable(BuildContext context, IconData icon,Color color,  Function dragCallBack) {
    return Draggable(
      axis: Axis.horizontal,
      feedback: _buildDragWidget(color, Icons.local_hospital),
      child: _buildDragWidget(
          color,icon),
      onDragStarted: () {
        setState(() {
          _isDragging = true;
        });
      },
      onDraggableCanceled: (v, offset) {
        setState(() {
          _isDragging = false;
        });
      },
      onDragEnd: (d){
        if (d.offset.dx.abs() > 160 || d.offset.dx.abs() < 100) {
          showDialog(
              context: context,
              builder: (BuildContext context){
                return CustomConfirmDialog(title: "确定要更改当前状态吗？");
              }
          ).then((value)async{
             if(value!=null && value){
               await dragCallBack(context);
             }
          });
        }
      },
    );
  }

  Widget _buildCenter(state) {
    return Transform.rotate(
        angle: state ? math.pi : 0,
        child: Container(
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.keyboard_arrow_right, color: Colors.indigo),
            const Icon(Icons.keyboard_arrow_right, color: Colors.indigo),
            const Icon(Icons.keyboard_arrow_right, color: Colors.indigo),
          ]),
        ));
  }

  Widget _buildDragTarget(IconData icon) {
    return DragTarget(
      onWillAccept: (bool state) {
        return true;
      },
      builder: (BuildContext context, List<dynamic> candidateData,
          List<dynamic> rejectedData) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        );
      },
    );
  }

  Widget _buildDragWidget(Color color, IconData icon) {
    return Container(
      height: 48,
      width: 60,
      decoration:
      BoxDecoration(color: _isDragging?Colors.transparent:color, borderRadius: BorderRadius.circular(50)),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

