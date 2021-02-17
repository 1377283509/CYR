import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/pages/patients_page/widgets/single_tile.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/custom_tile/expansion_card.dart';
import 'package:cyr/widgets/custom_tile/no_expansion_card.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:cyr/widgets/icon/state_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<Map<String, String>> mrsData = [
  {
    "grade": "0级 完全无症状",
  },
  {
    "grade": "1级 有症状无明显残疾",
    "description": "能完成所有经常从事的工作和活动",
  },
  {
    "grade": "2级 轻度残障",
    "description": "不能完成所有的工作和活动，但可以处理个人事务不需要他人帮助",
  },
  {
    "grade": "4级 重度残疾",
    "description": "离开他人帮助不能行走，不能照顾自己的身体需要",
  },
  {
    "grade": "5级 严重残疾",
    "description": "卧床不起，大小便失禁，须持续护理和照顾",
  },
];

class MRSCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftIcon(Consumer<MRSProvider>(
              builder: (_, provider, __) {
                return StateIcon(provider.endTime != null);
              },
            )),
          ),
          Expanded(
            flex: 8,
            child: FutureBuilder(
              future: Provider.of<MRSProvider>(context, listen: false)
                  .getNIHSS(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<MRSProvider>(
                    builder: (_, provider, __) {
                      return ExpansionCard(
                        title: "mRS评分",
                        children: [
                          // 有通知时间，说明已经通知
                          SingleTile(
                            title: "结果",
                            value: provider.result,
                            buttonLabel: "选择",
                            onTap: () async {
                              DateTime startTime = DateTime.now();
                              Doctor doctor = Provider.of<DoctorProvider>(
                                      context,
                                      listen: false)
                                  .user;
                              String secondLineDoctorId =
                                  Provider.of<SecondLineDoctorProvider>(context,
                                          listen: false)
                                      .secondDoctorId;
                              if (doctor.idCard != secondLineDoctorId) {
                                showToast("二线医生权限", context);
                                return;
                              }
                              List<String> res = await showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ListView.separated(
                                      itemCount: mrsData.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return CustomDivider();
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index == 0) {
                                          return ListTile(
                                            title:
                                                Text(mrsData[index]["grade"]),
                                            trailing: const Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.grey,
                                            ),
                                            onTap: () {
                                              Navigator.pop(context,
                                                  [mrsData[index]["grade"]]);
                                            },
                                          );
                                        }
                                        return ListTile(
                                          title: Text(mrsData[index]["grade"]),
                                          subtitle: Text(
                                              mrsData[index]["description"]),
                                          trailing: const Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.grey,
                                          ),
                                          onTap: () {
                                            Navigator.pop(context,
                                                [mrsData[index]["grade"]]);
                                          },
                                        );
                                      },
                                    );
                                  });
                              // 如果有输入
                              if (res != null && res.length > 0) {
                                await provider.setResult(context, startTime,
                                    doctor.idCard, doctor.name, "${res[0]}");
                              }
                            },
                          ),
                          // 完成时间
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
                    title: "mRS评分",
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
