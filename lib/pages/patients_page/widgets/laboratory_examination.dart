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
        Provider.of<VisitRecordProvider>(context, listen: false).bangle;
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
                              // 扫描手环
                              if (!await _checkBangle(context, curBangleId)) {
                                return;
                              }
                              Doctor doctor = Provider.of<DoctorProvider>(
                                      context,
                                      listen: false)
                                  .user;
                              // 权限检查
                              if (!permissionHandler(
                                  PermissionType.LABORATORY_EXAMINATION,
                                  doctor.department)) {
                                showConfirmDialog(context, "无权限",
                                    content: "该操作需由检验科人员进行");
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
                              // 校验手环
                              if (!await _checkBangle(context, curBangleId)) {
                                return;
                              }
                              Doctor doctor = Provider.of<DoctorProvider>(
                                      context,
                                      listen: false)
                                  .user;
                              // 权限检查
                              if (!permissionHandler(
                                  PermissionType.LABORATORY_EXAMINATION,
                                  doctor.department)) {
                                showConfirmDialog(context, "无权限",
                                    content: "该操作需由检验科人员进行");
                                return;
                              }
                              await provider.setArriveTime(
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
                              children: provider.endTime == null && provider.images.isEmpty
                                  ? [
                                      SingleTile(
                                        title: "结果图片",
                                        buttonLabel: "上传",
                                        onTap: () async {
                                          // 权限校验
                                          String department =
                                              Provider.of<DoctorProvider>(
                                                      context,
                                                      listen: false)
                                                  .user
                                                  .department;
                                          if (!permissionHandler(
                                              PermissionType
                                                  .LABORATORY_EXAMINATION,
                                              department)) {
                                            showConfirmDialog(context, "无权限",
                                                content: "该操作需由检验科人员进行");
                                            return;
                                          }
                                          List<String> res = await navigateTo(
                                              context,
                                              ChangeNotifierProvider(
                                                  create:
                                                      (BuildContext context) =>
                                                          FilesProvider(),
                                                  child: UploadImagePage()));
                                                  print(res);
                                          if (res != null) {
                                            // 更新图片
                                            await provider.setImages(
                                                context, res);
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
                            value: provider.endTime == null
                                ? null
                                : formatTime(provider.endTime),
                            buttonLabel: "完成",
                            onTap: () async {
                              String department = Provider.of<DoctorProvider>(
                                      context,
                                      listen: false)
                                  .user
                                  .department;
                              if(!permissionHandler(PermissionType.LABORATORY_EXAMINATION, department)){
                                showConfirmDialog(context, "无权限", content: "该操作需由检验科人员进行");
                                return;
                              }
                              bool res = await showConfirmDialog(
                                  context, "确认完成吗?",
                                  content: "一旦确认将不可更改");
                              if (res) {
                                await provider.setEndTime(context);
                              }
                            },
                          ),
                          // 无图片提示
                          Visibility(
                            visible: provider.endTime != null &&
                                provider.images.isEmpty,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Text(
                                "未上传图片",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          )
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
