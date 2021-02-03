import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/image_page/upload_image.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/pages/patients_page/widgets/single_tile.dart';
import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/providers/patient_detail/ecg_provider.dart';
import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:cyr/providers/utils/utils_provider.dart';
import 'package:cyr/utils/permission/permission.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/image_card/image_card.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EctCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
      children: [
        Expanded(
          flex: 1,
          child: LeftIcon(Consumer<ECGProvider>(
            builder: (_,ecgProvider, __){
              return StateIcon(ecgProvider.ecgModel?.endTime!=null);
            },
          )),
        ),
        Expanded(
            flex: 8,
            child: FutureBuilder(
              future: Provider.of<ECGProvider>(context, listen: false).getECG(context),
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
                          onTap: () async{
                            // 扫描手环Id
                            String bangleId = await scan();
                            // 获取患者手环Id
                            String curBangleId = Provider.of<VisitRecordProvider>(context, listen: false).bangle;
                            if(bangleId != curBangleId){
                              showToast("患者信息不匹配", context);
                              return;
                            }
                            Doctor doctor = Provider.of<DoctorProvider>(context,
                                    listen: false)
                                .user;
                            if(!permissionHandler(PermissionType.ECG, doctor.department)){
                              showConfirmDialog(context, "无权限", content: "该操作需由影像科人员进行");
                              return;
                            }
                            provider.setDoctor(
                                context, doctor.idCard, doctor.name);
                          },
                        ),
                        // 图片
                        Container(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runAlignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 2,
                            children:provider.endTime == null && provider.images.isEmpty
                                ? [
                                    SingleTile(
                                      title: "结果图片",
                                      buttonLabel: "上传",
                                      onTap: () async {
                                        // 权限校验
                                        String doctorId = Provider.of<DoctorProvider>(context, listen: false).user.idCard;
                                        if(doctorId!=provider.ecgModel.doctorId){
                                          showToast("无权限", context);
                                          return;
                                        }
                                        List<String> res = await navigateTo(
                                            context,
                                            ChangeNotifierProvider(
                                                create:
                                                    (BuildContext context) =>
                                                        FilesProvider(),
                                                child: UploadImagePage()));
                                        if (res != null) {
                                          // 更新图片
                                          await provider.setImages(context, res);
                                        }
                                      },
                                    ),
                                  ]
                                : provider.images
                                    .map((e) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ImageCard(e),
                                    ))
                                    .toList(),
                          ),
                        ),
                        // 完成时间
                        SingleTile(
                          title: "完成时间",
                          value: formatTime(provider.ecgModel.endTime) ,
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
