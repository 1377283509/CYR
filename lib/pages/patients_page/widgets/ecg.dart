import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/pages/patients_page/widgets/single_tile.dart';
import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/providers/patient_detail/ecg_provider.dart';
import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:cyr/utils/permission/permission.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EctCard extends StatelessWidget {
  // 权限检查
  bool checkPermission(BuildContext context, String department) {
    if (!permissionHandler(PermissionType.ECG, department)) {
      showToast("急诊科权限", context);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Doctor doctor = Provider.of<DoctorProvider>(context, listen: false).user;
    return IntrinsicHeight(
        child: Row(
      children: [
        Expanded(
          flex: 1,
          child: LeftIcon(Consumer<ECGProvider>(
            builder: (_, ecgProvider, __) {
              return StateIcon(ecgProvider.ecgModel?.endTime != null);
            },
          )),
        ),
        Expanded(
            flex: 8,
            child: FutureBuilder(
              future: Provider.of<ECGProvider>(context, listen: false)
                  .getECG(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<ECGProvider>(builder: (_, provider, __) {
                    return ExpansionCard(
                      title: "心电图检查",
                      children: [
                        SingleTile(
                          title: "开始时间",
                          value: provider.ecgModel.startTime == null
                              ? null
                              : formatTime(provider.ecgModel.startTime),
                          buttonLabel: "开始",
                          onTap: () async {
                            if (!checkPermission(context, doctor.department))
                              return;
                            // 扫描手环Id
                            String bangleId = await scan(context);
                            // 获取患者手环Id
                            String curBangleId =
                                Provider.of<VisitRecordProvider>(context,
                                        listen: false)
                                    .bangle;
                            if (bangleId != curBangleId) {
                              showToast("患者信息不匹配", context);
                              return;
                            }

                            provider.setDoctor(
                                context, doctor.idCard, doctor.name);
                          },
                        ),

                        // 完成时间
                        SingleTile(
                          title: "完成时间",
                          buttonLabel: "完成",
                          value: provider.ecgModel.endTime == null
                              ? null
                              : formatTime(provider.ecgModel.endTime),
                          onTap: () async {
                            // 检查权限
                            if (!checkPermission(context, doctor.department))
                              return;
                            // 是否开始
                            if (provider.ecgModel?.startTime == null) {
                              showToast("还未开始", context);
                              return;
                            }
                            // 更新完成时间
                            await provider.setEndTime(context);
                          },
                        ),
                      ],
                    );
                  });
                } else {
                  return NoExpansionCard(
                    title: "心电图检查",
                    trailing: CupertinoActivityIndicator(),
                  );
                }
              },
            )),
      ],
    ));
  }
}
