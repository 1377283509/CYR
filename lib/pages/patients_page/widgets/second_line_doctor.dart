import 'package:cyr/models/doctor/doctor_model.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/pages/patients_page/widgets/single_tile.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/permission/permission.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondLineDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftIcon(RoundIcon(Icons.person, Colors.orange)),
          ),
          Expanded(
            flex: 8,
            child: FutureBuilder(
              future:
                  Provider.of<SecondLineDoctorProvider>(context, listen: false)
                      .getSecondLineInfo(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<SecondLineDoctorProvider>(
                    builder: (_, provider, __) {
                      return ExpansionCard(
                        title: "二线医生",
                        children: [
                          // 有通知时间，说明已经通知
                          SingleTile(
                            title: "通知时间",
                            value: formatTime(Provider.of<VisitRecordProvider>(
                                    context,
                                    listen: true)
                                .createTime),
                          ),

                          // 到达时间
                          SingleTile(
                            title: "到达时间",
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
                                  PermissionType.SECOND_LINE_DOCTOR,
                                  doctor.department)) {
                                showToast("神经内科权限", context);
                                return;
                              }
                              // 扫码验证身份
                              String bangle = await scan(context);
                              String curBangle =
                                  Provider.of<VisitRecordProvider>(context,
                                          listen: false)
                                      .bangle;
                              if (bangle != curBangle) {
                                showToast("患者身份不匹配", context);
                                return;
                              }
                              // 到达
                              await provider.setArriveTime(
                                  context, doctor.idCard, doctor.name);
                            },
                          ),

                          // 二线医生
                          SingleTile(
                            title: "二线医生",
                            value: provider.secondDoctorName ?? "未到达",
                            onTap: () async {},
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return NoExpansionCard(
                    title: "二线医生",
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

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  DoctorCard(this.doctor);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Icon(Icons.fiber_manual_record,
            color: doctor.state ? Colors.green : Colors.red),
        title: Text(doctor.name),
        subtitle: Text("${doctor.department} ${doctor.gender} ${doctor.age}岁"),
        trailing: IconButton(
          icon: Icon(
            Icons.phone,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () async {
            Navigator.of(context).pop([doctor.idCard, doctor.name]);
            await launchPhone(doctor.phone);
          },
        ),
      ),
    );
  }
}
