import 'package:cyr/models/doctor/doctor_model.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/dialog/single_input_dialog.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/material.dart';
import 'single_tile.dart';
import 'package:provider/provider.dart';

class VisitInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftIcon(Consumer<VisitRecordProvider>(
              builder: (_,provider, __){
                return StateIcon(provider.visitRecordModel.result != null);
              },
            )),
          ),
          Expanded(
              flex: 8,
              child: Consumer<VisitRecordProvider>(builder: (_, provider, __) {
                return ExpansionCard(
                  title: "就诊信息",
                  children: [
                    SingleTile(
                      title: "就诊时间",
                      value: formatTime(provider.visitRecordModel.visitTime),
                    ),
                    SingleTile(
                      title: "诊断结果",
                      value: provider.visitRecordModel.result,
                      onTap: () async {
                        Doctor doctor =
                            Provider.of<DoctorProvider>(context, listen: false)
                                .user;
                        // 权限判断
                        if (doctor.idCard !=
                            provider.visitRecordModel.doctorId) {
                          showConfirmDialog(context, "无权限", content: "修改需由主治医师进行");
                          return;
                        }

                        List<String> res = await showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return SingleInputDialog(
                              label: "诊断结果",
                            );
                          }
                        );
                        if (res != null) {
                          await provider.setVisitResult(context, res[0]);
                        }
                      },
                    ),
                    SingleTile(
                      title: "短暂性脑缺血(TIA)",
                      value: provider.visitRecordModel.isTIA == null
                          ? null
                          : provider.visitRecordModel.isTIA
                              ? "是"
                              : "否",
                      buttonLabel: "选择",
                      onTap: () async {
                        Doctor doctor =
                            Provider.of<DoctorProvider>(context, listen: false)
                                .user;

                        if (doctor.idCard !=
                            provider.visitRecordModel.doctorId) {
                          showConfirmDialog(context, "无权限", content: "修改需由主治医师进行");
                          return;
                        }
                        bool res = await showConfirmDialog(context, "是否是短暂性脑缺血(TIA)?",confirmLabel: "是",cancelLabel: "否" );
                        // 更新TIA值
                        await provider.setTIA(context, res);
                      },
                    ),
                  ],
                );
              })),
        ],
      ),
    );
  }
}
