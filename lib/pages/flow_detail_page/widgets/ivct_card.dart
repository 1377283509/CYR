// 静脉溶栓信息
import 'package:cyr/models/record/ivct.dart';
import 'package:cyr/pages/flow_detail_page/widgets/card_title.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/pages/input_page/input_risk_assessment.dart';
import 'package:cyr/providers/patient_detail/ivct_provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:cyr/widgets/text/background_color_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IVCTCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("静脉溶栓"),
          FutureBuilder(
            future: Provider.of<IVCTProvider>(context, listen: false)
                .getIVCT(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<IVCTProvider>(
                  builder: (_, ivctProvider, __) {
                    IVCTModel ivctModel = ivctProvider.ivctModel;
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CustomDivider(),
                          ListTile(
                            title: Text("风险评估"),
                            onTap: () {
                              navigateTo(
                                  context,
                                  RiskAssessmentPage(
                                    ivctModel.riskAssessment,
                                    enableEdit: false,
                                  ));
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ColorText(
                                  text: ivctModel.riskAssessment?.appearTime ??
                                      "暂无",
                                  textStyle: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.chevron_right_outlined,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                          const CustomDivider(),
                          KVCell("开始知情", formatTime(ivctModel.startWitting)),
                          const CustomDivider(),
                          KVCell("签署知情", formatTime(ivctModel.endWitting)),
                          const CustomDivider(),
                          KVCell("前NIHSS评分", ivctModel.beforeNIHSS ?? '暂无'),
                          const CustomDivider(),
                          KVCell("溶栓开始", formatTime(ivctModel.startTime)),
                          const CustomDivider(),
                          KVCell("溶栓给药", ivctModel.medicineInfo ?? '暂无'),
                          const CustomDivider(),
                          KVCell("后NIHSS评分", ivctModel.afterNIHSS ?? '暂无'),
                          const CustomDivider(),
                          KVCell("不良反应", ivctModel.adverseReaction ?? "暂无"),
                          const CustomDivider(),
                          KVCell("完成时间", formatTime(ivctModel.endTime)),
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
