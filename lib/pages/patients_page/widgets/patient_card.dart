import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyr/models/model_list.dart';
import '../patient_detail.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  PatientCard(this.patient);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            PatientDetailPage(id: patient.id,));
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 12.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          children: [
            _buildTop(context),
            Divider(
              color: Colors.grey[400],
              height: 0,
            ),
            _buildBody()
          ],
        ),
      ),
    );
  }

  // card top
  Widget _buildTop(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.local_hotel,
              color: Colors.white,
            ),
            onPressed: () async {
              showQrCode(context, patient.id);
            },
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 2),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "${patient.gender}  ${patient.age}岁",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
          Visibility(
            visible: patient.isWeekUpStroke,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(35)
              ),
              child: Text("醒后卒中", style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),),
            ),
          )
        ],
      ),
    );
  }

  // card body
  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 主治医生
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              "主治医生：${patient.doctorName ?? '暂无'}",
            ),
          ),
          // 就诊时间
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
                "发病时间：${formatTime(patient.diseaseTime, format: TimeFormatType.MONTH_DAY_HOUR_MINUTE)}"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
                "就诊时间：${formatTime(patient.visitTime, format: TimeFormatType.MONTH_DAY_HOUR_MINUTE)}"),
          ),
          // 身份证号
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text("身份证号：${patient.idCard}"),
          ),
        ],
      ),
    );
  }
}
