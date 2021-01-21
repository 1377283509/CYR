import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/material.dart';

import 'left_icon.dart';
import 'single_tile.dart';
import 'package:provider/provider.dart';

class PatientInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftIcon(StateIcon(true)),
          ),
          Expanded(
              flex: 8,
              child: Consumer<VisitRecordProvider>(
                builder: (_, provider, __){
                  return ExpansionCard(
                    title: "患者信息",
                    children: [
                      SingleTile(
                        title: "姓名",
                        value: provider.visitRecordModel.patientName??"",
                      ),
                      SingleTile(
                        title: "性别",
                        value: provider.visitRecordModel.patientGender??"",
                      ),
                      SingleTile(
                        title: "年龄",
                        value: "${provider.visitRecordModel.patientAge} 岁"??"",
                      ),
                      SingleTile(
                        title: "身份证号",
                        value: provider.visitRecordModel.patientId??"",
                      ),
                    ],
                  );
                },
              )),
        ],
      ),
    );
  }
}
