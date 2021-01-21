import 'dart:typed_data';
import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/dialog/show_dialog.dart';
import 'package:cyr/utils/permission/permission.dart';
import 'package:cyr/utils/qr_code/qr_code_util.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BindDoctor extends StatelessWidget {
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
              child: NoExpansionCard(
                title: "主治医生",
                trailing: Consumer<VisitRecordProvider>(
                  builder: (_, provider, __) {
                    if (provider.doctorId == null) {
                      return TextButton(
                        child: Text("点击绑定"),
                        onPressed: () async {
                          Doctor doctor = Provider.of<DoctorProvider>(context,
                                  listen: false)
                              .user;
                          if(!permissionHandler(PermissionType.DOCTOR, doctor.department)){
                            showToast("无权限", context);
                            return;
                          }
                          bool res = await showConfirmDialog(
                              context,
                              "主治医生绑定确认",
                              content: "姓名: ${doctor.name} \n职工号: ${doctor.idCard}");
                          if (res) {
                            await provider.setDoctor(
                                context, doctor.idCard, doctor.name);
                          }
                        },
                      );
                    }
                    return Text(
                      provider.doctorName,
                      style: TextStyle(color: Colors.grey),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
