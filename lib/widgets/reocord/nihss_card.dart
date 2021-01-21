import 'package:cyr/models/record/nihss.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/text/background_color_text.dart';
import 'package:flutter/material.dart';

import '../widget_list.dart';

class NIHSSCard extends StatelessWidget {
  final NIHSSModel  nihssModel;
  NIHSSCard(this.nihssModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, bottom: 16, right: 12),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 姓名和ID
          ListTile(
            dense: true,
            title: Text(
              "责任医生",
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            trailing: ColorText(
              text: nihssModel.doctorName,
              backgroundColor: Colors.red,
            ),
          ),

          CustomListTile(
            title: Text("职工号"),
            trailing: Text(nihssModel.doctorId, style: TextStyle(
              color: Colors.grey
            ),),
          ),

          CustomListTile(
            title: Text("开始时间"),
            trailing: ColorText(text: formatTime(nihssModel.startTime)),
          ),

          CustomListTile(
            title: Text("结束时间"),
            trailing: ColorText(text: formatTime(nihssModel.endTime)),
          ),
        ],
      ),
    );
  }
}
