import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/input_page/select_input_page.dart';
import 'package:cyr/pages/page_list.dart';
import 'package:cyr/providers/patient/patient_provider.dart';
import 'package:cyr/utils/navigator/custom_navigator.dart';
import 'package:cyr/utils/ocr/id_card_ocr.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../widgets/title/card_title.dart';

/// 添加患者
class AddPatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          "添加患者",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: AddPatientPageBody(),
    );
  }
}

/// body
class AddPatientPageBody extends StatefulWidget {
  @override
  _AddPatientPageBodyState createState() => _AddPatientPageBodyState();
}

class _AddPatientPageBodyState extends State<AddPatientPageBody> {
  bool _selected;
  bool _ocrIng;
  String _defaultValue;

  IDCard _idCard;

  // 主诉
  String _chiefComplaint;
  // 是否醒后卒中
  bool _isWakeUpStroke;
  // 既往史
  String _pastHistory;
  DateTime _diseaseTime;
  WayToHospital _way;

  String _doctorId;
  String _doctorName;
  String _bangle;

  bool _loading;

  @override
  void initState() {
    super.initState();
    _idCard = IDCard();
    _diseaseTime = DateTime.now();
    _way = WayToHospital.BY_SELF;
    _loading = false;
    _ocrIng = false;
    _selected = false;
    _defaultValue = "点击输入";
    _isWakeUpStroke = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BlankSpace(),
          _buildBaseInfo(),
          const BlankSpace(),
          _buildRecordInfoCard(),
          const BlankSpace(),
          _buildOtherInfoCard(),
          const BlankSpace(),
          // Container(
          //   alignment: Alignment.centerLeft,
          //   padding: const EdgeInsets.symmetric(horizontal: 12),
          //   child: const Text(
          //     " * 注：主治医生、手环可在患者详情页进行绑定",
          //     style: TextStyle(color: Colors.white, fontSize: 12),
          //   ),
          // ),
          const BlankSpace(),
          _buildButton(),
          const BlankSpace(),
        ],
      ),
    );
  }

  _break(String message) {
    showToast(message, context);
    setState(() {
      _loading = false;
    });
  }

  // 保存按钮
  Widget _buildButton() {
    return Consumer<PatientProvider>(
      builder: (_, patientProvider, __) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomButton(
              loading: _loading,
              onTap: () async {
                if (_loading == true) {
                  return;
                }
                setState(() {
                  _loading = true;
                });
                if (_idCard.name == null ||
                    _idCard.id == null ||
                    _idCard.address == null ||
                    _idCard.gender == null) {
                  _break("患者信息不完善");
                  return;
                }
                if (_pastHistory == null) {
                  _break("既往史不能为空");
                  return;
                }
                if (_chiefComplaint == null) {
                  _break("主诉不能为空");
                  return;
                }
                await patientProvider.createPatient(
                    context,
                    _idCard,
                    _pastHistory,
                    _chiefComplaint,
                    _isWakeUpStroke,
                    _diseaseTime,
                    wayName[_way]);
              },
              title: "保存",
              backgroundColor: Colors.orangeAccent,
            ));
      },
    );
  }

  // 主治医生信息、到院方式、手环
  Widget _buildOtherInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // 主治医生
          // ListTile(
          //   title: const Text(
          //     "主治医生",
          //   ),
          //   onTap: () {
          //     navigateTo(context, DoctorListPage()).then((value) {
          //       if (value != null && value != []) {
          //         setState(() {
          //           _doctorName = value[1];
          //           _doctorId = value[0];
          //         });
          //       }
          //     });
          //   },
          //   leading: const Icon(Icons.person, color: Colors.red),
          //   subtitle: Text(_doctorName ?? "点击绑定"),
          //   trailing:
          //       const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          // ),
          // // 手环
          // ListTile(
          //   title: const Text(
          //     "绑定手环",
          //   ),
          //   onTap: () async {
          //     String bangle = await scan();
          //     setState(() {
          //       _bangle = bangle;
          //     });
          //   },
          //   leading: const Icon(Icons.watch, color: Colors.green),
          //   subtitle: Text(_bangle ?? "未绑定"),
          //   trailing: const Icon(Icons.qr_code_scanner, color: Colors.grey),
          // ),
          // // 来院方式
          ListTile(
            title: const Text(
              "到院方式",
            ),
            onTap: () async {
              List<WayToHospital> res = await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    List<WayToHospital> ways = wayName.keys.toList();
                    return ListView.separated(
                      itemCount: ways.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return CustomDivider();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(wayName[ways[index]]),
                          trailing: const Icon(Icons.keyboard_arrow_right,
                              color: Colors.grey),
                          onTap: () {
                            Navigator.pop(context, [ways[index]]);
                          },
                        );
                      },
                    );
                  });
              if (res != null) {
                setState(() {
                  _way = res[0];
                });
              }
            },
            leading: const Icon(Icons.polymer, color: Colors.blue),
            subtitle: Text(wayName[_way] ?? "无"),
            trailing:
                const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // 病情信息
  Widget _buildRecordInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            const CardTitle("病情信息"),
            // 是否醒后卒中
            ListTile(
                title: _buildLabel("醒后卒中", true),
                trailing: InkWell(
                  onTap: () {
                    setState(() {
                      _isWakeUpStroke = !_isWakeUpStroke;
                    });
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _isWakeUpStroke
                            ? Colors.indigo.withOpacity(0.6)
                            : Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      _isWakeUpStroke ? "是" : "否",
                      style: TextStyle(
                          color:
                              _isWakeUpStroke ? Colors.white : Colors.black54),
                    ),
                  ),
                )),
            const CustomDivider(),
            // 既往史
            InkWell(
              onTap: () {
                navigateTo(
                    context,
                    SelectInputPage(
                      title: "既 往 史",
                      values: ["高血压", "糖尿病", "冠心病", "房颤", "脑卒中", "血脂异常"],
                    )).then((value) {
                  if (value != null && value.length != 0) {
                    setState(() {
                      _pastHistory = value[0];
                    });
                  }
                });
              },
              child: ListTile(
                title: _buildLabel("既往史", true),
                subtitle: Text(_pastHistory ?? _defaultValue),
              ),
            ),
            const CustomDivider(),
            // 主诉
            InkWell(
                onTap: () {
                  navigateTo(
                      context,
                      SingleInputPage(
                        title: "主诉",
                        value: _chiefComplaint,
                      )).then((value) {
                    if (value != null && value.length != 0) {
                      setState(() {
                        _chiefComplaint = value[0];
                      });
                    }
                  });
                },
                child: ListTile(
                  title: _buildLabel("主诉", true),
                  subtitle: Text(_chiefComplaint ?? _defaultValue),
                )),
            const CustomDivider(),
            // 发病时间
            ListTile(
              title: _buildLabel("发病时间", true),
              onTap: () async {
                DateTime date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now(),
                    initialDatePickerMode: DatePickerMode.day,
                    initialEntryMode: DatePickerEntryMode.calendar,
                    fieldLabelText: "月/日/年",
                    confirmText: "确定",
                    cancelText: "取消",
                    fieldHintText: "输入日期",
                    helpText: "选择发病日期",
                    errorFormatText: "时间格式：月/日/年",
                    errorInvalidText: "不得早于1个月");
                TimeOfDay time = await showTimePicker(
                    cancelText: "取消",
                    confirmText: "确认",
                    helpText: "选择时间",
                    context: context,
                    initialTime: TimeOfDay.now());

                if (date != null && time != null) {
                  setState(() {
                    _diseaseTime = DateTime(date.year, date.month, date.day,
                        time.hour, time.minute);
                  });
                }
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatTime(_diseaseTime,
                        format: TimeFormatType.YEAR_MONTH_DAY_DOUR_MINUTE),
                    style: TextStyle(color: Colors.black54),
                  ),
                  const Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                ],
              ),
            ),
          ]),
    );
  }

  // label
  Widget _buildLabel(String title, bool isRequired) {
    return Text.rich(
      TextSpan(
        text: title,
        children: [
          isRequired
              ? TextSpan(text: "*", style: const TextStyle(color: Colors.red))
              : TextSpan()
        ],
      ),
    );
  }

  // 身份信息卡片
  Widget _buildBaseInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          title: Text(
            "身份信息",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.swap_horiz,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _selected = false;
              });
            },
          ),
        ),
        const CustomDivider(),
        _ocrIng
            ? _buildOCRCard()
            : _selected
                ? _buildInfo()
                : _buildButtons()
      ]),
    );
  }

  // OCR识别中的 占位widget
  Widget _buildOCRCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(),
          const BlankSpace(),
          const Text(
            "识别中...",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          )
        ],
      ),
    );
  }

  // 身份信息
  Widget _buildInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 姓名
        InkWell(
          onTap: () {
            navigateTo(
                context,
                SingleInputPage(
                  title: "姓名",
                  value: _idCard.name,
                )).then((value) {
              if (value != null && value.length != 0) {
                setState(() {
                  _idCard.name = value[0];
                });
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomListTile(
              leading: _buildLabel("  姓    名  ", true),
              title: Text(
                _idCard.name ?? _defaultValue,
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        // 性别
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: const Text("选择性别"),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      ListTile(
                        title: const Text("男"),
                        trailing: Icon(Icons.radio_button_unchecked),
                        onTap: () {
                          Navigator.of(context).pop(["男"]);
                        },
                      ),
                      const CustomDivider(),
                      ListTile(
                        title: const Text("女"),
                        trailing: const Icon(Icons.radio_button_unchecked),
                        onTap: () {
                          Navigator.of(context).pop(["女"]);
                        },
                      ),
                    ],
                  );
                }).then((value) {
              if (value != null && value.length > 0) {
                setState(() {
                  _idCard.gender = value[0];
                });
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomListTile(
              leading: _buildLabel("  性    别  ", true),
              title: Text(
                _idCard.gender ?? _defaultValue,
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        // 年龄
        InkWell(
          onTap: () {
            navigateTo(
                context,
                SingleInputPage(
                  title: "年龄",
                  value: _idCard.age == null ? "" : _idCard.age.toString(),
                  inputType: TextInputType.number,
                )).then((value) {
              if (value != null && value.length != 0) {
                setState(() {
                  _idCard.age = int.parse(value[0]);
                });
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomListTile(
              leading: _buildLabel("  年    龄  ", true),
              title: Text(
                _idCard.age == null
                    ? _defaultValue
                    : _idCard.age.toString() + " 岁",
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        // 身份证号
        InkWell(
          onTap: () {
            navigateTo(
                context,
                SingleInputPage(
                  title: "身份证号",
                  value: _idCard.id,
                  inputType: TextInputType.number,
                  maxLength: 18,
                )).then((value) {
              if (value != null && value.length != 0) {
                setState(() {
                  _idCard.id = value[0];
                });
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomListTile(
              leading: _buildLabel("身份证号", true),
              title: Text(
                _idCard.id ?? _defaultValue,
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          ),
        ),

        // 家庭住址
        InkWell(
          onTap: () {
            navigateTo(
                context,
                SingleInputPage(
                  title: "家庭住址",
                  value: _idCard.address,
                  inputType: TextInputType.text,
                )).then((value) {
              if (value != null && value.length != 0) {
                setState(() {
                  _idCard.address = value[0];
                });
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomListTile(
              leading: _buildLabel("家庭住址  ", false),
              title: Text(
                _idCard.address ?? _defaultValue,
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ocr
  _ocr() async {
    setState(() {
      _ocrIng = true;
    });
    try {
      IDCard idCard = await idCardOCR(context);
      if (idCard != null) {
        setState(() {
          _selected = true;
          _idCard = idCard;
          _ocrIng = false;
        });
      } else {
        setState(() {
          _selected = true;
          _ocrIng = false;
        });
      }
    } catch (e) {
      setState(() {
        _ocrIng = false;
      });
    }
  }

  // 搜索
  _search() async {
    showSearch(context: context, delegate: SearchPatientsPage()).then((value) {
      if (value != null) {
        IDCard idCard = IDCard.fromString(value);
        setState(() {
          _idCard = idCard;
          _selected = true;
        });
      }
    });
  }

  // 信息录入方式
  Widget _buildButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 拍照上传
        ListTile(
          onTap: _ocr,
          leading: const Icon(
            Icons.camera_alt,
            color: Colors.blue,
          ),
          title: const Text("拍照上传"),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
        ),

        // 库中搜索
        ListTile(
          onTap: _search,
          leading: const Icon(
            Icons.search,
            color: Colors.orange,
          ),
          title: const Text("库中查询"),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
        ),

        // 手动输入
        ListTile(
          leading: const Icon(
            Icons.edit_rounded,
            color: Colors.purple,
          ),
          title: const Text("手动录入"),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () {
            setState(() {
              _selected = true;
            });
          },
        ),
      ],
    );
  }
}

Map<WayToHospital, String> wayName = {
  WayToHospital.AMBULANCE: "本院急救车",
  WayToHospital.LOCAL_120: "本地120",
  WayToHospital.OTHER_120: "外地120",
  WayToHospital.TRANSFER: "外院转院",
  WayToHospital.BY_SELF: "自行来院",
};

enum WayToHospital { AMBULANCE, BY_SELF, LOCAL_120, OTHER_120, TRANSFER }
