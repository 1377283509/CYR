import 'package:cyr/models/doctor/doctor_model.dart';
import 'package:cyr/pages/page_list.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/dialog/show_dialog.dart';
import 'package:cyr/utils/permission/permission.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/custom_tile/expansion_card.dart';
import 'package:cyr/widgets/custom_tile/no_expansion_card.dart';
import 'package:cyr/widgets/icon/state_icon.dart';
import 'package:cyr/widgets/image_card/image_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'single_tile.dart';
import 'package:provider/provider.dart';

class LaboratoryExaminationCard extends StatelessWidget {
  // 校验手环
  // [curId]: 当前患者手环Id
  Future<bool> _checkBangle(BuildContext context, String curId) async {
    String bangleId = await scan();
    if (curId != bangleId) {
      showToast("患者身份不匹配", context);
    }
    return curId == bangleId;
  }

  @override
  Widget build(BuildContext context) {
    String curBangleId =
        Provider.of<VisitRecordProvider>(context, listen: true).bangle;
    return IntrinsicHeight(
        child: Row(
      children: [
        Expanded(
          flex: 1,
          child: LeftIcon(Consumer<LaboratoryExaminationProvider>(
            builder: (_, provider, __) {
              return StateIcon(provider.endTime != null);
            },
          )),
        ),
        Expanded(
          flex: 8,
          child: FutureBuilder(
              future: Provider.of<LaboratoryExaminationProvider>(context,
                      listen: false)
                  .getByVisitRecord(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<LaboratoryExaminationProvider>(
                    builder: (_, provider, __) {
                      return ExpansionCard(
                        title: "化验检查",
                        children: [
                          SingleTile(
                            title: "开始抽血",
                            buttonLabel: "开始",
                            value: provider.bloodTime == null
                                ? null
                                : formatTime(provider.bloodTime),
                            onTap: () async {
                              Doctor doctor = Provider.of<DoctorProvider>(
                                  context,
                                  listen: false)
                                  .user;
                              // 权限检查
                              if (!permissionHandler(
                                  PermissionType.LABORATORY_EXAMINATION, doctor.department)) {
                                showToast('急诊科权限', context);
                                return;
                              }
                              // 扫描手环
                              if (!await _checkBangle(context, curBangleId)) {
                                return;
                              }
                              await provider.startDrawBlood(
                                  context, doctor.idCard, doctor.name);
                            },
                          ),
                          SingleTile(
                            title: "到达化验室",
                            buttonLabel: "到达",
                            value: provider.arriveLaboratoryTime == null
                                ? null
                                : formatTime(provider.arriveLaboratoryTime),
                            onTap: () async {
                              Doctor doctor = Provider.of<DoctorProvider>(
                                  context,
                                  listen: false)
                                  .user;
                              // 权限检查
                              if (!permissionHandler(
                                  PermissionType.LABORATORY_EXAMINATION,
                                  doctor.department)) {
                                showToast('急诊科权限', context);
                                return;
                              }
                              // 校验手环
                              if (!await _checkBangle(context, curBangleId)) {
                                return;
                              }

                              await provider.setArriveTime(
                                  context, doctor.idCard, doctor.name);
                            },
                          ),
                          
                          SingleTile(
                            title: "完成时间",
                            value: provider.endTime == null ? null : formatTime(provider.endTime),
                            buttonLabel: "完成",
                            onTap: ()async{
                              Doctor doctor = Provider.of<DoctorProvider>(context, listen: false).user;
                              if (!permissionHandler(
                                  PermissionType.LABORATORY_EXAMINATION, doctor.department)) {
                                showToast('急诊科权限', context);
                                return;
                              }
                              await provider.setEndTime(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return NoExpansionCard(
                    title: "化验检查",
                    trailing: CupertinoActivityIndicator(),
                  );
                }
              }),
        ),
      ],
    ));
  }
}
