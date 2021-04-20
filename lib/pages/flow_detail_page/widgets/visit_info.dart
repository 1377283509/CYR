import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/title/card_title.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisitInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("就诊信息"),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomDivider(),
                    // 到院时间
                    KVCell('到院时间', formatTime(visitRecordModel.arriveTime)),
                    const CustomDivider(),
                    // 就诊时间
                    KVCell("就诊时间", formatTime(visitRecordModel.visitTime)),
                    const CustomDivider(),

                    // 诊断结果
                    KVCell("诊断结果", visitRecordModel.result ?? "无"),
                    const CustomDivider(),
                    // 缺血性脑卒中
                    KVCell("缺血性脑卒中", visitRecordModel.isCI ? "是" : "否"),

                    const CustomDivider(),
                    // 缺血性脑卒中
                    KVCell("去向", visitRecordModel.lastStep ?? "无"),
                    const CustomDivider(),
                    KVCell("急诊科医生",
                        "${visitRecordModel.doctorName ?? '暂无'} ${visitRecordModel.doctorId ?? ''}"),
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
