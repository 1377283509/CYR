// 生命体征信息
import 'package:cyr/models/record/vitals_signs.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/patient_detail/vital_signs_provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/widgets/title/card_title.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VitalSignsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("生命体征"),
          FutureBuilder(
            future: Provider.of<VitalSignsProvider>(context, listen: false)
                .getVitalSigns(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<VitalSignsProvider>(
                  builder: (_, vitalSignsProvider, __) {
                    VitalSignsModel vitalSignsModel =
                        vitalSignsProvider.vitalSigns;
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CustomDivider(),
                          KVCell("开始时间", formatTime(vitalSignsModel.startTime)),
                          const CustomDivider(),
                          KVCell("血糖", vitalSignsModel.bloodSugar ?? "暂无"),
                          const CustomDivider(),
                          KVCell("血压", vitalSignsModel.bloodPressure ?? "暂无"),
                          const CustomDivider(),
                          KVCell("体重", vitalSignsModel.weight ?? "暂无"),
                          const CustomDivider(),
                          KVCell("结束时间", formatTime(vitalSignsModel.endTime)),
                          const CustomDivider(),
                          KVCell("责任医生",
                              "${vitalSignsModel.doctorName ?? '暂无'}${vitalSignsModel.doctorId ?? ''}"),
                        ],
                      ),
                    );
                  },
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
