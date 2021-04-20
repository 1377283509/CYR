import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/title/card_title.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiseaseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("发病信息"),
          // 发病时间
          const CustomDivider(),
          Consumer<VisitRecordProvider>(
            builder: (_, visitRecordProvider, __) {
              VisitRecordModel visitRecordModel =
                  visitRecordProvider.visitRecordModel;
              if (visitRecordModel == null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoActivityIndicator(),
                );
              }
              return Container(
                child: Column(
                  children: [
                    KVCell('发病时间', formatTime(visitRecordModel.diseaseTime)),
                    // 是否醒后卒中
                    const CustomDivider(),
                    KVCell("醒后卒中", visitRecordModel.isWeekUpStroke ? "是" : "否"),
                    // 主诉
                    const CustomDivider(),
                    KVCell("主诉", visitRecordModel.chiefComplaint ?? "无"),
                    // 既往史
                    const CustomDivider(),
                    KVCell("既往史", visitRecordModel.pastHistory ?? "无"),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
