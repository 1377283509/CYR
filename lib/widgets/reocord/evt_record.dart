import 'package:cyr/models/record/evt.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/text/background_color_text.dart';
import 'package:flutter/material.dart';

import '../widget_list.dart';

class EVTCard extends StatelessWidget {
  final EVTModel evtModel;
  EVTCard(this.evtModel);
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
              text: evtModel.doctorName,
              backgroundColor: Colors.red,
            ),
          ),

          CustomListTile(
            title: Text("职工号"),
            trailing: Text(evtModel.doctorId, style: TextStyle(
              color: Colors.grey
            ),),
          ),

          CustomListTile(
            title: Text("开始知情时间"),
            trailing: ColorText(text: formatTime(evtModel.startWitting)),
          ),

          CustomListTile(
            title: Text("签署知情时间"),
            trailing: ColorText(text: formatTime(evtModel.endWitting)),
          ),

          CustomListTile(
            title: Text("到达手术室大门时间"),
            trailing: ColorText(text: formatTime(evtModel.arriveTime)),
          ),

          CustomListTile(
            title: Text("上手术台时间"),
            trailing: ColorText(text: formatTime(evtModel.startTime)),
          ),

          CustomListTile(
            title: Text("责任血管评估时间"),
            trailing: ColorText(text: formatTime(evtModel.assetsTime)),
          ),

          CustomListTile(
            title: Text("穿刺完成时间"),
            trailing: ColorText(text: formatTime(evtModel.punctureTime)),
          ),

          CustomListTile(
            title: Text("造影完成时间"),
            trailing: ColorText(text: formatTime(evtModel.radiographyTime)),
          ),

          CustomListTile(
            title: Text("血管再通时间"),
            trailing: ColorText(text: formatTime(evtModel.revascularizationTime)),
          ),

          CustomListTile(
            title: Text("手术结束时间"),
            trailing: ColorText(text: formatTime(evtModel.endTime)),
          ),
        ],
      ),
    );
  }
}
