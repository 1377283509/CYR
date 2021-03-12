import 'package:cyr/models/record/laboratory_examination.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/text/background_color_text.dart';
import 'package:flutter/material.dart';

import '../widget_list.dart';

class LaboratoryExaminationCard extends StatelessWidget {
  final LaboratoryExamination laboratoryExamination;
  LaboratoryExaminationCard(this.laboratoryExamination);
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
              "抽血责任医生",
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            trailing: ColorText(
              text: laboratoryExamination.drawBloodDoctorName,
              backgroundColor: Colors.red,
            ),
          ),

          CustomListTile(
            title: Text("职工号"),
            trailing: Text(
              laboratoryExamination.drawBloodDoctorId,
              style: TextStyle(color: Colors.grey),
            ),
          ),

          CustomListTile(
            title: Text("抽血时间"),
            trailing:
                ColorText(text: formatTime(laboratoryExamination.bloodTime)),
          ),

          ListTile(
            dense: true,
            title: Text(
              "化验责任医生",
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            trailing: ColorText(
              text: laboratoryExamination.examinationDoctorName,
              backgroundColor: Colors.red,
            ),
          ),

          CustomListTile(
            title: Text("职工号"),
            trailing: Text(
              laboratoryExamination.examinationDoctorId,
              style: TextStyle(color: Colors.grey),
            ),
          ),

          CustomListTile(
            title: Text("抵达化验室时间"),
            trailing: ColorText(
                text: formatTime(laboratoryExamination.arriveLaboratoryTime)),
          ),

          CustomListTile(
            title: Text("结果上报时间"),
            trailing:
                ColorText(text: formatTime(laboratoryExamination.endTime)),
          ),
        ],
      ),
    );
  }
}
