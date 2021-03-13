import 'package:cyr/models/doctor/doctor_model.dart';
import 'package:cyr/models/record/risk_assessment.dart';
import 'package:cyr/pages/input_page/input_medicine_page.dart';
import 'package:cyr/pages/input_page/input_nihss_page.dart';
import 'package:cyr/pages/input_page/input_risk_assessment.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/providers/patient_detail/ivct_provider.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/dialog/single_input_dialog.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'single_tile.dart';

class IVCTCard extends StatelessWidget {
  // 权限检查: 判断当前用户是否是责任医生
  bool checkPermission(BuildContext context) {
    // 当前用户
    Doctor doctor = Provider.of<DoctorProvider>(context, listen: false).user;
    // 二线医生
    String desDoctorId =
        Provider.of<SecondLineDoctorProvider>(context, listen: false)
            .secondDoctorId;
    if (doctor.idCard == desDoctorId || doctor.hasRecordOwnership) {
      return true;
    }
    showToast("二线医生权限", context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftIcon(Consumer<IVCTProvider>(
              builder: (_, provider, __) {
                return StateIcon(provider.endTime != null);
              },
            )),
          ),
          Expanded(
            flex: 8,
            child: FutureBuilder(
              future: Provider.of<IVCTProvider>(context, listen: false)
                  .getIVCT(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<IVCTProvider>(
                    builder: (_, provider, __) {
                      return ExpansionCard(
                        title: "静脉溶栓",
                        children: [
                          // 风险评估
                          InkWell(
                            onTap: () async {
                              if (!checkPermission(context)) return;
                              List<RiskAssessmentModel> res = await navigateTo(
                                  context,
                                  RiskAssessmentPage(provider.riskAssessment));
                              if (res != null) {
                                // 保存数据
                                await provider.setRiskAssessment(
                                    context, res[0]);
                              }
                            },
                            child: SingleTile(
                              title: "风险评估",
                              value: provider.riskAssessment?.appearTime == null
                                  ? "点击输入"
                                  : provider.riskAssessment?.appearTime,
                            ),
                          ),
                          // 开始知情
                          SingleTile(
                            title: "开始知情",
                            buttonLabel: "确认",
                            value: provider.startWitting == null
                                ? null
                                : formatTime(provider.startWitting),
                            onTap: () async {
                              if (!checkPermission(context)) return;
                              await provider.setStartWitting(context);
                            },
                          ),
                          // 签署知情
                          SingleTile(
                            title: "签署知情",
                            buttonLabel: "确认",
                            value: provider.endWitting == null
                                ? null
                                : formatTime(provider.endWitting),
                            onTap: () async {
                              if (!checkPermission(context)) return;
                              await provider.setEndWitting(context);
                            },
                          ),
                          // 前NIHSS评分
                          SingleTile(
                            title: "前NIHSS评分",
                            buttonLabel: "输入",
                            value: provider.beforeNIHSS,
                            onTap: () async {
                              if (!checkPermission(context)) return;
                              List<int> res = await navigateTo(
                                context,
                                InputNIHSSPage(DateTime.now()),
                              );
                              // 如果有输入
                              if (res != null && res.length > 0) {
                                await provider.setBeforeNIHSS(
                                    context, "${res[0]} 分");
                              }
                            },
                          ),
                          // 溶栓开始时间
                          SingleTile(
                            title: "溶栓开始",
                            buttonLabel: "开始",
                            value: provider.startTime == null
                                ? null
                                : formatTime(provider.startTime),
                            onTap: () async {
                              if (!checkPermission(context)) return;
                              await provider.setStartTime(context);
                            },
                          ),
                          // 溶栓给药
                          SingleTile(
                            title: "溶栓给药",
                            buttonLabel: "输入",
                            value: provider.medicineInfo,
                            onTap: () async {
                              if (!checkPermission(context)) return;
                              List<String> res = await navigateTo(
                                  context, InputMedicinePage());
                              // 如果有输入
                              if (res != null && res.length > 0) {
                                await provider.setMedicineInfo(context, res[0]);
                              }
                            },
                          ),
                          // 后NIHSS评分
                          SingleTile(
                            title: "后NIHSS评分",
                            buttonLabel: "输入",
                            value: provider.afterNIHSS,
                            onTap: () async {
                              if (!checkPermission(context)) return;
                              List<int> res = await navigateTo(
                                  context, InputNIHSSPage(DateTime.now()));
                              // 如果有输入
                              if (res != null && res.length > 0) {
                                await provider.setAfterNIHSS(
                                    context, "${res[0]} 分");
                              }
                            },
                          ),
                          // 不良反应
                          SingleTile(
                            title: "不良反应",
                            buttonLabel: "输入",
                            value: provider.adverseReaction,
                            onTap: () async {
                              if (!checkPermission(context)) return;
                              List<String> res = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleInputDialog(
                                      label: "不良反应",
                                    );
                                  });
                              // 如果有输入
                              if (res != null && res.length > 0) {
                                await provider.setAdverseReaction(
                                    context, res[0]);
                              }
                            },
                          ),
                          // 完成时间
                          SingleTile(
                            title: "完成时间",
                            buttonLabel: "完成",
                            value: provider.endTime == null
                                ? null
                                : formatTime(provider.endTime),
                            onTap: () async {
                              if (!checkPermission(context)) return;
                              await provider.setEndTime(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return NoExpansionCard(
                    title: "静脉溶栓",
                    trailing: CupertinoActivityIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
