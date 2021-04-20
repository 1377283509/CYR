// 二线医生信息
import 'package:cyr/models/record/second_line_doctor.dart';
import 'package:cyr/pages/flow_detail_page/widgets/card_title.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/patient_detail/second_line_doctor_provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondLineDoctorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("二线信息"),
          FutureBuilder(
            future:
                Provider.of<SecondLineDoctorProvider>(context, listen: false)
                    .getSecondLineInfo(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<SecondLineDoctorProvider>(
                  builder: (_, secondLineProvider, __) {
                    SecondLineDoctorModel secondLineDoctorModel =
                        secondLineProvider.secondlineDoctor;
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CustomDivider(),
                          KVCell(
                              "通知时间",
                              formatTime(
                                  secondLineDoctorModel.notificationTime)),
                          const CustomDivider(),
                          KVCell("通知医生",
                              "${secondLineDoctorModel.doctorName ?? '暂无'}${secondLineDoctorModel.doctorId ?? ''}"),
                          const CustomDivider(),
                          KVCell("到达时间",
                              formatTime(secondLineDoctorModel.arriveTime)),
                          const CustomDivider(),
                          KVCell("二线医生",
                              "${secondLineDoctorModel.secondDoctorName ?? '暂无'}${secondLineDoctorModel.secondDoctorId ?? ''}"),
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
