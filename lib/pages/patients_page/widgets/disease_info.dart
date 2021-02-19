import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/material.dart';
import 'single_tile.dart';
import 'package:provider/provider.dart';

class DiseaseInfoCard extends StatelessWidget {
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
              child: Consumer<VisitRecordProvider>(builder: (_, provider, __) {
                return ExpansionCard(
                  title: "发病信息",
                  children: [
                    SingleTile(
                      title: "主诉",
                      value: provider.visitRecordModel.chiefComplaint??"",
                    ),
                    SingleTile(
                      title: "既往史",
                      value: provider.visitRecordModel.pastHistory??"",
                    ),
                    SingleTile(
                      title: "发病时间",
                      value: formatTime(provider.visitRecordModel.diseaseTime),
                    ),
                    SingleTile(
                      title: "醒后卒中",
                      value: provider.visitRecordModel.isWeekUpStroke?"是":"否",
                    ),
                  ],
                );
              })),
        ],
      ),
    );
  }
}
