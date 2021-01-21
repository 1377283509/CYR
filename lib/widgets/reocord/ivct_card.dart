import 'package:cyr/models/record/ivct.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/text/background_color_text.dart';
import 'package:flutter/material.dart';

import '../widget_list.dart';

class IVCTCard extends StatelessWidget {
  final IVCTModel ivctModel;
  IVCTCard(this.ivctModel);
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
              text: ivctModel.doctorName,
              backgroundColor: Colors.red,
            ),
          ),

          CustomListTile(
            title: Text("职工号"),
            trailing: Text(ivctModel.doctorId, style: TextStyle(
              color: Colors.grey
            ),),
          ),

          CustomListTile(
            title: Text("开始知情时间"),
            trailing: ColorText(text: formatTime(ivctModel.startWitting)),
          ),

          CustomListTile(
            title: Text("签署知情时间"),
            trailing: ColorText(text: formatTime(ivctModel.endWitting)),
          ),

          CustomListTile(
            title: Text("溶栓开始时间"),
            trailing: ColorText(text: formatTime(ivctModel.endWitting)),
          ),

          CustomListTile(
            title: Text("溶栓完成时间"),
            trailing: ColorText(text: formatTime(ivctModel.endTime)),
          ),
        ],
      ),
    );
  }
}
