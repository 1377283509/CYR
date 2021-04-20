// 心电图信息
import 'package:cyr/models/record/ECG.dart';
import 'package:cyr/pages/flow_detail_page/widgets/card_title.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/patient_detail/ecg_provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:cyr/widgets/image_card/image_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ECGCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("心电图"),
          FutureBuilder(
            future: Provider.of<ECGProvider>(context, listen: false)
                .getECG(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<ECGProvider>(
                  builder: (_, ecgProvider, __) {
                    ECGModel ecgModel = ecgProvider.ecgModel;
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CustomDivider(),
                          KVCell("开始时间", formatTime(ecgModel.startTime)),
                          const CustomDivider(),
                          KVCell("结束时间", formatTime(ecgModel.endTime)),
                          const CustomDivider(),
                          KVCell("责任医生",
                              "${ecgModel.doctorName ?? '暂无'} ${ecgModel.doctorId ?? ''}"),
                          const CustomDivider(),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: ecgModel.images ??
                                    []
                                        .map(
                                          (e) => Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8),
                                              child: ImageCard(e)),
                                        )
                                        .toList(),
                              )),
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
