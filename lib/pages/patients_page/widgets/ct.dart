import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/providers/patient_detail/ct_provider.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/permission/permission.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/custom_tile/expansion_card.dart';
import 'package:cyr/widgets/custom_tile/no_expansion_card.dart';
import 'package:cyr/widgets/icon/state_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'single_tile.dart';

class CTCard extends StatelessWidget {
  // 检查患者身份
  Future<bool> _checkBangle(BuildContext context, String curBangleId) async {
    String bangle;
    try {
      bangle = await scan(context);
    } catch (e) {}

    if (bangle != curBangleId) {
      showToast("患者身份不匹配", context);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String curBangleId =
        Provider.of<VisitRecordProvider>(context, listen: false).bangle;
    return IntrinsicHeight(
        child: Row(
      children: [
        Expanded(
          flex: 1,
          child: LeftIcon(Consumer<CTProvider>(
            builder: (_, provider, __) {
              return StateIcon(provider.endTime != null);
            },
          )),
        ),
        Expanded(
            flex: 8,
            child: FutureBuilder(
              future: Provider.of<CTProvider>(context, listen: false)
                  .getCT(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<CTProvider>(
                    builder: (_, provider, __) {
                      return ExpansionCard(
                        title: "CT检查",
                        children: [
                          // 开单时间
                          SingleTile(
                            title: "开单时间",
                            buttonLabel: "完成",
                            value: provider.orderTime == null
                                ? null
                                : formatTime(provider.orderTime),
                            onTap: () async {
                              //检查身份权限
                              Doctor doctor = Provider.of<DoctorProvider>(
                                      context,
                                      listen: false)
                                  .user;

                              // 获取主治医生id
                              String dutyDoctorId =
                                  Provider.of<VisitRecordProvider>(context,
                                          listen: false)
                                      .doctorId;

                              if (doctor.idCard != dutyDoctorId) {
                                showToast("急诊科权限", context);
                                return;
                              }
                              // 更新开单时间
                              await provider.setOrderTime(
                                  context, doctor.idCard, doctor.name);
                            },
                          ),

                          // 到达CT室时间
                          SingleTile(
                            title: "到达CT室",
                            value: provider.arriveTime == null
                                ? null
                                : formatTime(provider.arriveTime),
                            buttonLabel: "到达",
                            onTap: () async {
                              Doctor doctor = Provider.of<DoctorProvider>(
                                      context,
                                      listen: false)
                                  .user;
                              if (!permissionHandler(
                                  PermissionType.CT, doctor.department)) {
                                showToast("影像科权限", context);
                                return;
                              }
                              if (!await _checkBangle(context, curBangleId))
                                return;
                              await provider.setArriveTime(
                                  context, doctor.idCard, doctor.name);
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
                              Doctor doctor = Provider.of<DoctorProvider>(
                                      context,
                                      listen: false)
                                  .user;
                              if (!permissionHandler(
                                  PermissionType.CT, doctor.department)) {
                                showToast("影像科权限", context);
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
                    title: "CT检查",
                    trailing: CupertinoActivityIndicator(),
                  );
                }
              },
            )),
      ],
    ));
  }
}
