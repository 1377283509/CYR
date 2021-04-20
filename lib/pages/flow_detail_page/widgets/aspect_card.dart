// aspect评分
import 'package:cyr/models/record/aspect.dart';
import 'package:cyr/pages/flow_detail_page/widgets/card_title.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/patient_detail/aspect_provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AspectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("Aspect评分"),
          const CustomDivider(),
          FutureBuilder(
              future: Provider.of<AspectProvider>(context, listen: false)
                  .getDataByVisitRecordId(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<AspectProvider>(
                    builder: (_, aspectProvider, __) {
                      AspectModel aspectModel = aspectProvider.aspectModel;
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            KVCell("开始时间", formatTime(aspectModel.startTime)),
                            const CustomDivider(),
                            KVCell("上报时间", formatTime(aspectModel.endTime)),
                            const CustomDivider(),
                            KVCell("总分", "${aspectModel.totalScore ?? '暂无'}"),
                            const CustomDivider(),
                            KVCell("去除A、P、Po、Cb四项得分",
                                "${aspectModel.score ?? '暂无'}"),
                            const CustomDivider(),
                            KVCell("结果", aspectModel.result ?? "暂无"),
                            const CustomDivider(),
                            KVCell("责任医生",
                                "${aspectModel.doctorName ?? '暂无'}${aspectModel.doctorId ?? ''}"),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: CupertinoActivityIndicator(),
                );
              }),
        ],
      ),
    );
  }
}
