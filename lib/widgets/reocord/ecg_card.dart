import 'package:cyr/models/record/ECG.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/text/background_color_text.dart';
import 'package:flutter/material.dart';

import '../widget_list.dart';

class ECGCard extends StatelessWidget {
  final ECGModel ecgModel;
  ECGCard(this.ecgModel);
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
              text: ecgModel.doctorName,
              backgroundColor: Colors.red,
            ),
          ),

          CustomListTile(
            title: Text("职工号"),
            trailing: Text(ecgModel.doctorId, style: TextStyle(
              color: Colors.grey
            ),),
          ),

          CustomListTile(
            title: Text("开始时间"),
            trailing: ColorText(text: formatTime(ecgModel.startTime)),
          ),

          CustomListTile(
            title: Text("结束时间"),
            trailing: ColorText(text: formatTime(ecgModel.endTime)),
          ),
        ],
      ),
    );
  }
}
