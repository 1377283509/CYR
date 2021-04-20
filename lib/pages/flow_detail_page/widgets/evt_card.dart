// 血管内治疗信息
import 'package:cyr/models/record/evt.dart';
import 'package:cyr/pages/flow_detail_page/widgets/card_title.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/patient_detail/evt_provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EVTCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("血管内治疗"),
          FutureBuilder(
            future: Provider.of<EVTProvider>(context, listen: false)
                .getByVisitRecord(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<EVTProvider>(
                  builder: (_, evtProvider, __) {
                    EVTModel evtModel = evtProvider.evtModel;
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CustomDivider(),
                          KVCell("开始知情", formatTime(evtModel.startWitting)),
                          const CustomDivider(),
                          KVCell("签署知情", formatTime(evtModel.endWitting)),
                          const CustomDivider(),
                          KVCell("前NIHSS评分", evtModel.beforeNIHSS ?? "暂无"),
                          const CustomDivider(),
                          KVCell("到达手术室大门", formatTime(evtModel.arriveTime)),
                          const CustomDivider(),
                          KVCell("上手术台", formatTime(evtModel.startTime)),
                          const CustomDivider(),
                          KVCell("责任血管评估", formatTime(evtModel.assetsTime)),
                          const CustomDivider(),
                          KVCell("穿刺", formatTime(evtModel.punctureTime)),
                          const CustomDivider(),
                          KVCell("造影", formatTime(evtModel.radiographyTime)),
                          const CustomDivider(),
                          KVCell(
                              "仅造影",
                              evtModel.onlyRadiography == null
                                  ? "暂无"
                                  : evtModel.onlyRadiography
                                      ? "是"
                                      : "否"),
                          const CustomDivider(),
                          KVCell("手术方法", evtModel.methods ?? "暂无"),
                          const CustomDivider(),
                          KVCell("血管再通",
                              formatTime(evtModel.revascularizationTime)),
                          const CustomDivider(),
                          KVCell("手术结束", formatTime(evtModel.endTime)),
                          const CustomDivider(),
                          KVCell("mTICI分级", evtModel.mTICI ?? "暂无"),
                          const CustomDivider(),
                          KVCell("治疗结果", evtModel.result ?? "暂无"),
                          const CustomDivider(),
                          KVCell("后NIHSS评分", evtModel.afterNIHSS ?? "暂无"),
                          const CustomDivider(),
                          KVCell("不良事件", evtModel.adverseReaction ?? "暂无"),
                          const CustomDivider(),
                          KVCell("责任医生",
                              "${evtModel.doctorName ?? '暂无'}${evtModel.doctorId ?? ''}"),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoActivityIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
