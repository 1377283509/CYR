// mrs评分
import 'package:cyr/models/record/mRS.dart';
import 'package:cyr/pages/flow_detail_page/widgets/card_title.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/patient_detail/mRS_provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MRSCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("MRS评分"),
          const CustomDivider(),
          FutureBuilder(
              future: Provider.of<MRSProvider>(context, listen: false)
                  .getMRS(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<MRSProvider>(
                    builder: (_, mrsProvider, __) {
                      MRSModel mrsModel = mrsProvider.mrsModel;
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            KVCell("开始时间", formatTime(mrsModel.startTime)),
                            const CustomDivider(),
                            KVCell("上报时间", formatTime(mrsModel.endTime)),
                            const CustomDivider(),
                            KVCell("结果", mrsModel.result ?? "暂无"),
                            const CustomDivider(),
                            KVCell("责任医生",
                                "${mrsModel.doctorName ?? '暂无'}${mrsModel.doctorId ?? ''}"),
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
