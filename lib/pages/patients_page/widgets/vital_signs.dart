import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/permission/permission.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/dialog/single_input_dialog.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'single_tile.dart';

class VitalSignsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VitalSignsProvider provider =
        Provider.of<VitalSignsProvider>(context, listen: false);
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: LeftIcon(
                Consumer<VitalSignsProvider>(
                  builder: (_, provider, __) {
                    return StateIcon(provider.vitalSigns?.endTime != null);
                  },
                ),
              )),
          Expanded(
            flex: 8,
            child: ExpansionCard(
              title: "生命体征",
              children: [
                FutureBuilder(
                  future: provider.getVitalSigns(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return VitalSignsWidget(provider.vitalSigns);
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VitalSignsWidget extends StatelessWidget {
  final VitalSignsModel vitalSigns;

  VitalSignsWidget(this.vitalSigns);
  Future<String> getInputValue(BuildContext context, String label,
      [String placeHolder, TextInputType inputType]) async {
    List<String> res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleInputDialog(
            label: label,
            placeHolder: placeHolder,
            inputTupe: inputType,
          );
        });
    if (res != null) {
      return res[0];
    }
    return null;
  }

  bool checkPermission(BuildContext context, String department) {
    if (!permissionHandler(PermissionType.VITAL_SIGNS, department)) {
      showToast("急诊科权限", context);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Doctor doctor =
                      Provider.of<DoctorProvider>(context, listen: false).user;
    return Container(
      child: Consumer<VitalSignsProvider>(
        builder: (_, provider, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 开始时间
              SingleTile(
                title: "开始时间",
                value: provider.startTime == null
                    ? null
                    : formatTime(provider.startTime),
                buttonLabel: "开始",
                onTap: () async {
                  // 校验权限
                  if (!checkPermission(context, doctor.department)) return;
                  // 手环二维码校验
                  // 获取患者手环id
                  String bangleId = await scan(context);
                  // 获取当前患者手环id
                  String curBangleId =
                      Provider.of<VisitRecordProvider>(context, listen: false)
                          .bangle;
                  if (curBangleId != null && bangleId != curBangleId) {
                    showToast("患者信息不匹配", context);
                    return;
                  }

                  // 更新开始时间
                  await provider.setDoctor(context, doctor.idCard, doctor.name);
                },
              ),

              // 血糖
              SingleTile(
                title: "血糖",
                value: provider.endTime == null
                    ? provider.bloodSugar
                    : "${provider.bloodSugar}",
                onTap: () async {
                 // 校验权限
                  if (!checkPermission(context, doctor.department)) return;
                  String res = await getInputValue(
                      context, "血糖", "单位：mmol/L", TextInputType.number);
                  // 如果有输入
                  if (res != null) {
                    await provider.setBloodSugar(context, "$res mmol/L");
                  }
                },
              ),
              SingleTile(
                title: "血压",
                value: provider.endTime == null
                    ? provider.bloodPressure
                    : "${provider.bloodPressure}",
                onTap: () async {
                  // 校验权限
                  if (!checkPermission(context, doctor.department)) return;
                  String res = await getInputValue(
                      context, "血压", "收缩压/舒张压 mmHg", TextInputType.number);
                  // 如果有输入
                  if (res != null) {
                    await provider.setBloodPressure(context, "$res mmHg");
                  }
                },
              ),
              SingleTile(
                title: "体重",
                value: provider.endTime == null
                    ? provider.weight
                    : "${provider.weight}",
                onTap: () async {
                  // 校验权限
                  if (!checkPermission(context, doctor.department)) return;
                  String res = await getInputValue(
                      context, "体重", "单位：kg", TextInputType.number);
                  if (res != null) {
                    await provider.setWeight(context, "$res kg");
                  }
                },
              ),
              SingleTile(
                title: "完成时间",
                value: vitalSigns.endTime == null
                    ? null
                    : formatTime(vitalSigns.endTime),
                onTap: () async {
                  // 校验权限
                  if (!checkPermission(context, doctor.department)) return;
                  await provider.setEndTime(context);
                },
                buttonLabel: "完成",
              ),
            ],
          );
        },
      ),
    );
  }
}
