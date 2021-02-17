import 'package:cyr/models/record/second_line_doctor.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/text/background_color_text.dart';
import 'package:flutter/material.dart';

import '../widget_list.dart';

class SecondLineDoctorCard extends StatelessWidget {
  final SecondLineDoctorModel secondLineDoctorModel;
  SecondLineDoctorCard(this.secondLineDoctorModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, bottom: 16, right: 12),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            title: Text(
              "通知医生",
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            trailing: ColorText(
              text: secondLineDoctorModel.doctorName,
              backgroundColor: Colors.red,
            ),
          ),
          CustomListTile(
            title: Text("职工号"),
            trailing: Text(
              secondLineDoctorModel.doctorId,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          CustomListTile(
            title: Text("通知时间"),
            trailing: ColorText(
                text: formatTime(secondLineDoctorModel.notificationTime)),
          ),
          ListTile(
            dense: true,
            title: Text(
              "二线医生",
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            trailing: ColorText(
              text: secondLineDoctorModel.secondDoctorName,
              backgroundColor: Colors.red,
            ),
          ),
          CustomListTile(
            title: Text("职工号"),
            trailing: Text(
              secondLineDoctorModel.secondDoctorId,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          CustomListTile(
            title: Text("到达时间"),
            trailing:
                ColorText(text: formatTime(secondLineDoctorModel.arriveTime)),
          ),
        ],
      ),
    );
  }
}
