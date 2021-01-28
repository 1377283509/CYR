import 'package:cyr/pages/input_page/input_nihss_page.dart';
import 'package:cyr/pages/patients_page/widgets/bool_card.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/providers/patient_detail/evt_provider.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/custom_tile/no_expansion_card.dart';
import 'package:cyr/widgets/dialog/single_input_dialog.dart';
import 'package:cyr/widgets/icon/state_icon.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'single_tile.dart';

// ignore: must_be_immutable
class EVTCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
      children: [
        Expanded(
          flex: 1,
          child: LeftIcon(Consumer<EVTProvider>(
            builder: (_, provider, __) {
              return StateIcon(provider.endTime != null);
            },
          )),
        ),
        Expanded(
          flex: 8,
          child: FutureBuilder(
              future: Provider.of<EVTProvider>(context, listen: false)
                  .getByVisitRecord(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ExpansionCard(title: "血管内治疗", children: [
                    _buildStartWitting(context),
                    _buildEndWitting(context),
                    _buildBeforeNIHSS(context),
                    _buildArriveTime(context),
                    _buildStartTime(context),
                    _buildAssetsTime(context),
                    _buildPunctureTime(context),
                    _buildRadiographyTime(context),
                    _buildOnlyRadiography(context),
                    _buildMethods(context),
                    _buildRevascularizationTime(context),
                    _buildEndTime(context),
                    _buildMTICI(context),
                    _buildResult(context),
                    _buildAfterNIHSS(context),
                    _buildAdverseReaction(context),
                  ]);
                } else {
                  return NoExpansionCard(
                    title: "血管内治疗",
                    trailing: CupertinoActivityIndicator(),
                  );
                }
              }),
        ),
      ],
    ));
  }

  bool checkPermission(BuildContext context) {
    return true;
  }

  Future<bool> checkbangle(BuildContext context) async {
    String bangle = await scan();
    String curBangle = Provider.of<VisitRecordProvider>(context, listen: false).bangle;
    if (bangle != curBangle) {
      showToast("患者身份不匹配", context);
      return false;
    }
    return true;
  }

  Future<void> eventHandle(BuildContext context, Future callback) async {
    if (!checkPermission(context)) {
      showToast("无权限", context);
      return;
    }
    print("执行回调");
    await callback;
  }

  // 开始知情
  _buildStartWitting(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "开始知情",
        buttonLabel: "确认",
        value: provider.startWitting == null
            ? null
            : formatTime(provider.startWitting),
        onTap: () async {
          await eventHandle(context, provider.setStartWitting(context));
        },
      );
    });
  }

  // 签署知情
  _buildEndWitting(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "签署知情",
        buttonLabel: "确认",
        value: provider.endWitting == null
            ? null
            : formatTime(provider.endWitting),
        onTap: () async {
          await eventHandle(context, provider.setEndWitting(context));
        },
      );
    });
  }

  // 前NIHSS评分
  _buildBeforeNIHSS(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "前NIHSS评分",
        value: provider.beforeNIHSS,
        buttonLabel: "输入",
        onTap: () async {
          List<int> res =
              await navigateTo(context, InputNIHSSPage(DateTime.now()));
          // 如果有输入
          if (res != null && res.length > 0) {
            await provider.setBeforeNIHSS(context, "${res[0]} 分");
          }
        },
      );
    });
  }

  // 到达手术室大门时间
  _buildArriveTime(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "到达手术室大门",
        buttonLabel: "确认",
        value: provider.arriveTime == null
            ? null
            : formatTime(provider.arriveTime),
        onTap: () async {
          bool res = await checkbangle(context);
          if (res) {
            await eventHandle(context, provider.setArriveTime(context));
          }
        },
      );
    });
  }

  // 上手术台时间
  _buildStartTime(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "上手术台",
        buttonLabel: "确认",
        value:
            provider.startTime == null ? null : formatTime(provider.startTime),
        onTap: () async {
          if (await checkbangle(context)) {
            await eventHandle(context, provider.setStartTime(context));
          }
        },
      );
    });
  }

  // 责任血管评估完成时间
  _buildAssetsTime(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "责任血管评估",
        buttonLabel: "完成",
        value: provider.assetsTime == null
            ? null
            : formatTime(provider.assetsTime),
        onTap: () async {
          await eventHandle(context, provider.setAssetsTime(context));
        },
      );
    });
  }

  // 穿刺开始时间
  _buildPunctureTime(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "穿刺",
        value: provider.punctureTime == null
            ? null
            : formatTime(provider.punctureTime),
        buttonLabel: "开始",
        onTap: () async {
          await eventHandle(context, provider.setPunctureTime(context));
        },
      );
    });
  }

  // 造影完成时间
  _buildRadiographyTime(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "造影",
        value: provider.radiographyTime == null
            ? null
            : formatTime(provider.radiographyTime),
        buttonLabel: "完成",
        onTap: () async {
          await eventHandle(context, provider.setRadiographyTime(context));
        },
      );
    });
  }

  // 仅造影
  _buildOnlyRadiography(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "仅造影",
        value: provider.onlyRadiography == null
            ? null
            : provider.onlyRadiography
                ? "是"
                : "否",
        buttonLabel: "选择",
        onTap: () async {
          bool res = await showConfirmDialog(context, "仅造影",
              confirmLabel: "是", cancelLabel: "否");
          await eventHandle(context, provider.setOnlyRadiography(context, res));
        },
      );
    });
  }

  List<String> _methods = [
    "支架取栓",
    "抽栓",
    "球囊成形",
    "支架成型",
    "动脉溶栓",
    "机械碎栓",
  ];
  // 手术方法
  _buildMethods(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "手术方法",
        buttonLabel: "选择",
        value: provider.methods,
        onTap: () async {
          List<String> res = await showModalBottomSheet<List<String>>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return CustomDivider();
                    },
                    itemCount: _methods.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pop([_methods[index]]);
                        },
                        title: Text(_methods[index]),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                );
              });
          if (res != null) {
            await eventHandle(context, provider.setMethods(context, res[0]));
          }
        },
      );
    });
  }

  // 血管再通时间
  _buildRevascularizationTime(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "血管再通",
        buttonLabel: "确认",
        value: provider.revascularizationTime == null
            ? null
            : formatTime(provider.revascularizationTime),
        onTap: () async {
          await eventHandle(
              context, provider.setRevascularizationTime(context));
        },
      );
    });
  }

  // 手术结束
  _buildEndTime(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "手术结束",
        buttonLabel: "确认",
        value: provider.endTime == null ? null : formatTime(provider.endTime),
        onTap: () async {
          await eventHandle(context, provider.setEndTime(context));
        },
      );
    });
  }

  List<String> _mTICI = [
    "0  无血流灌注",
    "1  仅有微量血流通过闭塞段",
    "2a 远端缺血区有部分血流灌注(<50%)",
    "2b 远端缺血区有血流灌注(>50%)",
    "3  远端缺血区血流完全恢复灌注",
  ];

  // mTICI分级
  _buildMTICI(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "mTICI分级",
        buttonLabel: "选择",
        value: provider.mTICI,
        onTap: () async {
          List<String> res = await showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: ListView.separated(
                    itemCount: _mTICI.length,
                    separatorBuilder: (context, index) {
                      return CustomDivider();
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_mTICI[index]),
                        onTap: () {
                          Navigator.of(context).pop([_mTICI[index]]);
                        },
                        trailing: const Icon(Icons.keyboard_arrow_right,
                            color: Colors.grey),
                      );
                    },
                  ),
                );
              });
          if (res != null) {
            await eventHandle(context, provider.setMTICI(context, res[0]));
          }
        },
      );
    });
  }

  // 手术结果
  _buildResult(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "治疗结果",
        buttonLabel: "输入",
        value: provider.result,
        onTap: () async {
          List<String> res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return SingleInputDialog(
                  label: "手术结果",
                );
              });
          // 如果有输入
          if (res != null && res.length > 0) {
            await provider.setResult(context, "${res[0]}");
          }
        },
      );
    });
  }

  // 后NIHSS评分
  _buildAfterNIHSS(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "后NIHSS评分",
        buttonLabel: "输入",
        value: provider.afterNIHSS,
        onTap: () async {
          List<int> res =
              await navigateTo(context, InputNIHSSPage(DateTime.now()));
          // 如果有输入
          if (res != null && res.length > 0) {
            await provider.setAfterNIHSS(context, "${res[0]} 分");
          }
        },
      );
    });
  }

  // 不良反应
  _buildAdverseReaction(BuildContext context) {
    return Consumer<EVTProvider>(builder: (_, provider, __) {
      return SingleTile(
        title: "不良事件",
        buttonLabel: "输入",
        value: provider.adverseReaction,
        onTap: () async {
          List<String> res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return SingleInputDialog(
                  label: "不良事件",
                );
              });
          // 如果有输入
          if (res != null && res.length > 0) {
            await provider.setAdverseReaction(context, "${res[0]}");
          }
        },
      );
    });
  }
}

class EVTConfirmCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftIcon(RoundIcon(Icons.compare_arrows, Colors.orange)),
          ),
          Expanded(
              flex: 8,
              child: Consumer<VisitRecordProvider>(
                builder: (_, provider, __) {
                  return NoExpansionCard(
                    title: "是否进行血管内治疗",
                    onTap: () async {
                      await provider.setEVT(context);
                    },
                    trailing: BoolCard(
                      state: provider.isEVT,
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
