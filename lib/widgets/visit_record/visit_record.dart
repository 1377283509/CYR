import 'package:cyr/models/model_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/material.dart';

import '../widget_list.dart';

class VisitRecordCard extends StatelessWidget {
 final VisitRecordModel visitRecord;

 VisitRecordCard(this.visitRecord);
  final TextStyle _textStyle = TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 患者信息
            Visibility(
                visible: visitRecord != null,
                child: _buildPatientCard(visitRecord)),
            const BlankSpace(),
            // 病情信息
            Visibility(
              visible: visitRecord != null,
              child: _buildRecordCard(visitRecord),
            ),
            const BlankSpace(),
            // 其他信息
            Visibility(
              visible: visitRecord != null,
              child: _buildOtherCard(visitRecord),
            ),
            const BlankSpace(),
          ],
        ),
      )
    );
  }

  Widget _buildPatientCard(VisitRecordModel visitRecord) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CardTitle("患者信息"),
          const CustomDivider(),
          // 姓名
          _buildCell("  姓    名  ", visitRecord.patientName),
          // 性别
          _buildCell("  性    别  ", visitRecord.patientGender),
          // 年龄
          _buildCell("  年    龄  ", "${visitRecord.patientAge} 岁"),
          // 身份证号
          _buildCell("身份证号", visitRecord.patientId),
        ],
      ),
    );
  }

  // 病情信息卡片
  Widget _buildRecordCard(VisitRecordModel visitRecord) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CardTitle("病情信息"),
          const CustomDivider(),
          // 是否醒后卒中
          ListTile(
            dense: true,
            title: Text(
              "醒后卒中",
              style: _textStyle,
            ),
            trailing: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: visitRecord.isWeekUpStroke
                      ? Colors.indigo.withOpacity(0.6)
                      : Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6)),
              child: Text(
                visitRecord.isWeekUpStroke ? "是" : "否",
                style: TextStyle(
                    color: visitRecord.isWeekUpStroke
                        ? Colors.white
                        : Colors.black54),
              ),
            ),
          ),
          // 既往史
          ListTile(
            dense: true,
            title: Text(
              "既往史",
              style: _textStyle,
            ),
            subtitle: Text(visitRecord.pastHistory ?? "无", style: _textStyle),
          ),
          // 主诉
          ListTile(
            dense: true,
            title: Text("主诉", style: _textStyle),
            subtitle:
                Text(visitRecord.chiefComplaint ?? "无", style: _textStyle),
          ),
          // 发病时间
          ListTile(
            dense: true,
            title: Text("发病时间", style: _textStyle),
            trailing: Text(formatTime(visitRecord.diseaseTime)),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherCard(VisitRecordModel visitRecord) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CardTitle("就诊信息"),
          const CustomDivider(),
          ListTile(
            dense: true,
            leading: const Icon(Icons.person, color: Colors.red),
            title: Text("主治医生", style: _textStyle),
          ),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.watch_later,
              color: Colors.blue,
            ),
            title: Text("就诊时间", style: _textStyle),
            subtitle: Text(formatTime(visitRecord.visitTime)),
          ),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.business,
              color: Colors.orange,
            ),
            title: Text("病房", style: _textStyle),
          ),
        ],
      ),
    );
  }

  // 单行cell
  Widget _buildCell(String label, String value, [Widget trailing]) {
    return CustomListTile(
        leading: Text(label),
        title: Text(
          value ?? "",
        ),
        trailing: trailing ?? Container());
  }
}
