import 'package:cyr/models/model_list.dart';
import 'package:cyr/models/record/aspect.dart';
import 'package:cyr/pages/input_page/input_aspect_page.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/pages/patients_page/widgets/single_tile.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/permission/permission.dart';
import 'package:cyr/utils/qr_code/qr_code_util.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AspectCard extends StatelessWidget {
  // 检查患者身份
  Future<bool> _checkBangle(BuildContext context, String curBangleId) async {
    String bangle = await scan();
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
            child: LeftIcon(Consumer<AspectProvider>(
              builder: (_, provider, __) {
                print(provider.endTime);
                return StateIcon(provider.endTime!=null);
              },
            )),
          ),
          Expanded(
              flex: 8,
              child: FutureBuilder(
                future: Provider.of<AspectProvider>(context, listen: false)
                    .getDataByVisitRecordId(context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Consumer<AspectProvider>(
                      builder: (context, provider, child) {
                        return ExpansionCard(
                          title: "ASPECT评分",
                          children: [
                            Visibility(
                              visible: provider.totalScore != null,
                              child: SingleTile(
                                title: "总分",
                                value: provider.totalScore.toString(),
                              ),
                            ),
                            Visibility(
                              visible: provider.score != null,
                              child: SingleTile(
                                title: "去除A、P、Po、Cb四项得分",
                                value: provider.totalScore.toString(),
                              ),
                            ),
                            SingleTile(
                              title: "结果",
                              buttonLabel: "输入",
                              value: provider.result,
                              onTap: () async {
                                //检查身份权限
                                Doctor doctor = Provider.of<DoctorProvider>(
                                        context,
                                        listen: false)
                                    .user;
                                if (!permissionHandler(
                                    PermissionType.CT, doctor.department)) {
                                  showToast("该操作只能由影像科进行", context);
                                  return;
                                }
                                // 检查患者身份
                                if (!await _checkBangle(context, curBangleId))
                                  return;
                                DateTime startTime = DateTime.now();
                                // res[0]:总分, res[1]：去除A、P、Po、Cb的得分, res[2]：结果
                                List<String> res = await navigateTo(
                                    context, InputAspectPage());
                                AspectModel aspect = AspectModel(
                                    startTime: startTime,
                                    totalScore: int.parse(res[0]),
                                    score: int.parse(res[1]),
                                    result: res[2],
                                    endTime: DateTime.now(),
                                    doctorId: doctor.idCard,
                                    doctorName: doctor.name);
                                if (res != null && res.isNotEmpty) {
                                  await provider.setResult(context, aspect);
                                }
                              },
                            ),
                            SingleTile(
                              title: "完成时间",
                              value: formatTime(provider.endTime),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return NoExpansionCard(
                      title: "Aspect评分",
                      trailing: CupertinoActivityIndicator(),
                    );
                  }
                },
              ))
        ],
      ),
    );
  }
}
