// 患者信息
import 'package:cyr/models/record/record_model.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientDetailCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VisitRecordProvider>(
      builder: (_, visitRecordProvider, __) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CardTitle("患者信息"),
              CustomDivider(),
              Consumer<VisitRecordProvider>(
                builder: (_, visitRecordProvider, __) {
                  VisitRecordModel visitRecordModel =
                      visitRecordProvider.visitRecordModel;
                  if (visitRecordModel == null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  return Container(
                    child: Column(
                      children: [
                        _buildBaseInfo(
                            visitRecordModel.patientName,
                            visitRecordModel.patientGender,
                            visitRecordModel.patientAge),
                        KVCell("身份证号", visitRecordModel.patientId),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // 姓名、性别、年龄
  Widget _buildBaseInfo(String name, String gender, int age) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              name,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(gender),
          ),
          Expanded(
            flex: 1,
            child: Text("$age 岁"),
          ),
        ],
      ),
    );
  }
}
