import 'package:cyr/models/model_list.dart';
import 'package:cyr/models/record/aspect.dart';
import 'package:cyr/pages/input_page/input_aspect_page.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/pages/patients_page/widgets/single_tile.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cyr/providers/patient_detail/second_line_doctor_provider.dart';

class AspectCard extends StatelessWidget {
  final bool isAccidentRecourse;
  AspectCard({this.isAccidentRecourse = false});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftIcon(Consumer<AspectProvider>(
              builder: (_, provider, __) {
                return StateIcon(provider.endTime != null);
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
                              visible: provider.totalScore != null && !isAccidentRecourse,
                              child: SingleTile(
                                title: "总分",
                                value: provider.totalScore.toString(),
                              ),
                            ),
                            Visibility(
                              visible: provider.score != null && !isAccidentRecourse,
                              child: SingleTile(
                                title: "去除A、P、Po、Cb四项得分",
                                value: provider.totalScore.toString(),
                              ),
                            ),
                            Visibility(
                              visible:!isAccidentRecourse,
                              child: SingleTile(
                                title: "结果",
                                buttonLabel: "输入",
                                value: provider.result,
                                onTap: () async {
                                  //检查身份权限
                                  Doctor doctor = Provider.of<DoctorProvider>(
                                          context,
                                          listen: false)
                                      .user;
                                  String secondLineDoctorId =
                                      Provider.of<SecondLineDoctorProvider>(
                                              context,
                                              listen: false)
                                          .secondDoctorId;
                                  if (doctor.idCard != secondLineDoctorId && !doctor.hasRecordOwnership) {
                                    showToast("二线医生权限", context);
                                    return;
                                  }
                                  DateTime startTime = DateTime.now();
                                  // res[0]:总分, res[1]：去除A、P、Po、Cb的得分, res[2]：结果
                                  List<String> res = await navigateTo(
                                      context, InputAspectPage());
                                  if (res != null) {
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
                                  }
                                },
                              ),
                            ),
                            SingleTile(
                              title: "完成时间",
                              value: formatTime(provider.endTime),
                            ),
                            Visibility(
                              visible: isAccidentRecourse,
                              child: SingleTile(
                                title: "责任医生",
                                value: provider.doctorName,
                              ),
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    return NoExpansionCard(
                      title: "ASPECT评分",
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
