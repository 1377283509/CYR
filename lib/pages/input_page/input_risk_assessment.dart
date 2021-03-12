// 风险评估页面
import 'package:cyr/models/record/risk_assessment.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:flutter/material.dart';

class RiskAssessmentPage extends StatefulWidget {
  final RiskAssessmentModel riskAssessmentModel;
  RiskAssessmentPage(this.riskAssessmentModel);

  @override
  _RiskAssessmentPageState createState() => _RiskAssessmentPageState();
}

class _RiskAssessmentPageState extends State<RiskAssessmentPage> {
  RiskAssessmentModel _riskAssessmentModel;

  @override
  void initState() {
    super.initState();
    _riskAssessmentModel = widget.riskAssessmentModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("风险评估"),
        actions: [
          ElevatedButton(
            child: Text("保存", style: TextStyle(
              color: Colors.white
            ),),
            onPressed: (){
              Navigator.of(context).pop([_riskAssessmentModel]);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppearTime(),
            // 适应症
            _buildAdaptationDisease(),
            // 禁忌症
            _buildContraindication(),
            // 相对禁忌症
            _buildRelativeContraindications(),
            // 范围相对禁忌症
            _buildRangeRelativeContraindications()
          ],
        ),
      ),
    );
  }

  // 症状出现时长
  Widget _buildAppearTime() {
    List<String> appearTimeList = ["<3小时", "3~4.5小时", ">4.5小时"];
    return ListTile(
      tileColor: Colors.white,
      title: Text("症状出现时间"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_riskAssessmentModel?.appearTime ?? "点击选择"),
          SizedBox(width: 8,),
          Icon(Icons.keyboard_arrow_right, color: Colors.grey)
        ],
      ),
      onTap: () async {
        List<String> res = await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ListView.separated(
                itemCount: appearTimeList.length,
                separatorBuilder: (context, index) {
                  return CustomDivider();
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(appearTimeList[index]),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.of(context).pop([appearTimeList[index]]);
                    },
                  );
                },
              );
            });
        if (res != null) {
          setState(() {
            _riskAssessmentModel.appearTime = res[0];
          });
        }
      },
    );
  }

  // 适应症
  Widget _buildAdaptationDisease() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle("适应症"),
          _buildSwitchTile("有缺血性卒中导致的神经功能缺损症状", _riskAssessmentModel.hasSONI,
              (v) {
            setState(() {
              _riskAssessmentModel.hasSONI = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("年龄≥18岁", _riskAssessmentModel.hasAdult, (v) {
            setState(() {
              _riskAssessmentModel.hasAdult = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("患者或家属签署知情同意书", _riskAssessmentModel.hasEndWitting,
              (v) {
            setState(() {
              _riskAssessmentModel.hasEndWitting = v;
            });
          }),
        ],
      ),
    );
  }

  // 禁忌症
  Widget _buildContraindication() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle("禁忌症"),
          _buildSwitchTile(
              "近3个月有严重颅外伤或卒中史", _riskAssessmentModel.hasStrokeHistory, (v) {
            setState(() {
              _riskAssessmentModel.hasStrokeHistory = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("颅内出血(包括脑实质出血、蛛网膜下腔出血、硬膜外/硬膜下血肿等)",
              _riskAssessmentModel.intracranialHemorrhage, (v) {
            setState(() {
              _riskAssessmentModel.intracranialHemorrhage = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile(
              "近一周内有在不易压迫部位的动脉穿刺", _riskAssessmentModel.hasArteriopuncture,
              (v) {
            setState(() {
              _riskAssessmentModel.hasArteriopuncture = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile(
              "既往颅内出血", _riskAssessmentModel.hasIntracranialHemorrhageHistory,
              (v) {
            setState(() {
              _riskAssessmentModel.hasIntracranialHemorrhageHistory = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile(
              "颅内肿瘤、巨大颅内动脉瘤", _riskAssessmentModel.hasIntracranialTumors, (v) {
            setState(() {
              _riskAssessmentModel.hasIntracranialTumors = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile(
              "近期（三个月内）有颅内或锥管内手术史", _riskAssessmentModel.hasOperationHistory,
              (v) {
            setState(() {
              _riskAssessmentModel.hasOperationHistory = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("血压升高：收缩压>180mmHg，舒张压>100mmHg",
              _riskAssessmentModel.hasHypertension, (v) {
            setState(() {
              _riskAssessmentModel.hasHypertension = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile(
              "活动性内脏出血", _riskAssessmentModel.hasActiveVisceralBleeding, (v) {
            setState(() {
              _riskAssessmentModel.hasActiveVisceralBleeding = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("急性出血倾向，包括血小板计数低于100x109/L或其它情况",
              _riskAssessmentModel.hasAcuteBleedingTendency, (v) {
            setState(() {
              _riskAssessmentModel.hasAcuteBleedingTendency = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile(
              "24小时内接受过低分子肝素治疗（APTT超出正常范围上限）", _riskAssessmentModel.hasLMWH,
              (v) {
            setState(() {
              _riskAssessmentModel.hasLMWH = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile(
              "口服抗凝药物者INR值>1.7或PT>15秒", _riskAssessmentModel.hasHigherINPorPT,
              (v) {
            setState(() {
              _riskAssessmentModel.hasHigherINPorPT = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile(
              "48小时内使用凝血酶抑制剂或Xa因子抑制剂，各种敏感的实验室检查异常（如APTT，INR，血小板计数，TT或恰当的Xa因子活性测定等）",
              _riskAssessmentModel.abnormalLaboratory, (v) {
            setState(() {
              _riskAssessmentModel.abnormalLaboratory = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile(
              "血糖<2.8mmol/L或>22.22mmol/L", _riskAssessmentModel.pathoglycemia,
              (v) {
            setState(() {
              _riskAssessmentModel.pathoglycemia = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("头部CT或MRI提示大面积梗死（梗死面积大于1/3大脑半球）",
              _riskAssessmentModel.hasMassiveInfarction, (v) {
            setState(() {
              _riskAssessmentModel.hasMassiveInfarction = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("主动脉弓夹层", _riskAssessmentModel.isDissectedArch, (v) {
            setState(() {
              _riskAssessmentModel.isDissectedArch = v;
            });
          }),
        ],
      ),
    );
  }

  // 相对禁忌症
  Widget _buildRelativeContraindications(){
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle("相对禁忌症"),
          _buildSwitchTile("轻型非致残性卒中或症状快速改善的卒中", _riskAssessmentModel.isLightStroke,
                  (v) {
                setState(() {
                  _riskAssessmentModel.isLightStroke = v;
                });
              }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("妊娠", _riskAssessmentModel.hasGravidity, (v) {
            setState(() {
              _riskAssessmentModel.hasGravidity = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("癫痫发作后出现的神经功能损害症状（与此次卒中发生相关）", _riskAssessmentModel.hasSymptomsOfEpilepsy,
                  (v) {
                setState(() {
                  _riskAssessmentModel.hasSymptomsOfEpilepsy = v;
                });
              }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("近两周内有大型外科手术或严重外伤（未伤及头颅）", _riskAssessmentModel.hasSevereTrauma, (v) {
            setState(() {
              _riskAssessmentModel.hasSevereTrauma = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("近三周内有肠胃或泌尿系统出血", _riskAssessmentModel.hasUrinaryBleeding, (v) {
            setState(() {
              _riskAssessmentModel.hasUrinaryBleeding = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("颅外段颈动脉夹层", _riskAssessmentModel.hasECAD, (v) {
            setState(() {
              _riskAssessmentModel.hasECAD = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("痴呆", _riskAssessmentModel.isDementia, (v) {
            setState(() {
              _riskAssessmentModel.isDementia = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("既往疾病遗留较严重的神经功能残疾", _riskAssessmentModel.hasNeurologicalDisability, (v) {
            setState(() {
              _riskAssessmentModel.hasNeurologicalDisability = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("未破裂且未经治疗的动静脉畸形、颅内小动脉瘤（<10mm）", _riskAssessmentModel.hasArteryMalformation, (v) {
            setState(() {
              _riskAssessmentModel.hasArteryMalformation = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("少量颅内微出血（1~10个）", _riskAssessmentModel.hasIntracranialHemorrhage, (v) {
            setState(() {
              _riskAssessmentModel.hasIntracranialHemorrhage = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("使用违禁药物", _riskAssessmentModel.hasUsedIllegalDrugs, (v) {
            setState(() {
              _riskAssessmentModel.hasUsedIllegalDrugs = v;
            });
          }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("类卒中", _riskAssessmentModel.isParapoplexy, (v) {
            setState(() {
              _riskAssessmentModel.isParapoplexy = v;
            });
          }),
        ],
      ),
    );
  }

  // 范围相对禁忌症
  Widget _buildRangeRelativeContraindications(){
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle("适应症"),
          _buildSwitchTile("严重卒中（NIHSS评分>25分）", _riskAssessmentModel.isSevereStroke,
                  (v) {
                setState(() {
                  _riskAssessmentModel.isSevereStroke = v;
                });
              }),
          CustomDivider(thickness: 1, color: Colors.grey.withOpacity(0.2),),
          _buildSwitchTile("口服抗凝药，INR值≤1.7或PT≤15秒", _riskAssessmentModel.hasOralAnticoagulants, (v) {
            setState(() {
              _riskAssessmentModel.hasOralAnticoagulants = v;
            });
          }),
        ],
      ),
    );
  }

  // 开关Tile样式
  Widget _buildSwitchTile(String title, bool value, Function onTap) {
    return SwitchListTile(
      tileColor: Colors.white,
      value: value,
      title: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
      activeColor: Colors.indigo,
      activeTrackColor: Colors.indigo.withOpacity(0.5),
      inactiveThumbColor: Colors.grey[400],
      inactiveTrackColor: Colors.grey[300],
      onChanged: (v) {
        setState(() {
          onTap(v);
        });
      },
    );
  }

  // title样式
  Widget _buildTitle(String title) {
    return ListTile(
      dense: true,
      tileColor: Colors.grey.withOpacity(0.15),
      title: Text(
        title,
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
