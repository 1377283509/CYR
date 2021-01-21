import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SquareCard extends StatelessWidget {
  // 标题
  final String title;
  // 数量
  final String count;
  // 颜色
  final Color color;
  // 图标
  final IconData icon;

  SquareCard(
      {@required this.title,
      this.count,
      this.icon = Icons.fiber_manual_record,
      this.color = Colors.indigo});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width-24;
    return Container(
      width: width * .5,
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6)
      ),
      child: AspectRatio(
        aspectRatio: 3 / 1.2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              count == null
                  ? CupertinoActivityIndicator()
                  : Text(
                      count,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
