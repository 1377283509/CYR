import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/stat_page/widgets/stat_card.dart';
import 'package:cyr/providers/statistic/patient_statistic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 月患者统计
class MonthlyPatientChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12),
      child: Consumer<PatientStatisticProvider>(
        builder: (_, provider, __) {
          PatientStatisticModel curMonthData = provider.list.first;
          return Column(
            children: [
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: [
                  SquareCard(
                    title: "卒中患者数",
                    count: "${curMonthData.patientsCount} 人",
                    color: Colors.green,
                  ),
                  SquareCard(
                    title: "患者死亡数",
                    count: "${curMonthData.deathCount} 人",
                    color: Colors.red,
                  ),
                  SquareCard(
                    title: "DNT超时数",
                    count: "${curMonthData.dntTimeOutCount} 次",
                    color: Colors.orange,
                  ),
                  SquareCard(
                    title: "DNT平均用时",
                    count: "${curMonthData.dntAverageTime} 分钟",
                    color: Colors.blue,
                  ),
                  SquareCard(
                    title: "静脉溶栓",
                    count: "${curMonthData.ivctCount} 次",
                    color: Colors.indigo,
                  ),
                  SquareCard(
                    title: "血管内治疗",
                    count: "${curMonthData.evtCount} 次",
                    color: Colors.teal,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                alignment: Alignment.center,
                child: Text("${curMonthData.year} 年 ${curMonthData.month} 月", style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                ),),
              ),
            ],
          );
        },
      ),
    );
  }
}
