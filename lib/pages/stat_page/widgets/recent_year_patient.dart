import 'package:cyr/models/model_list.dart';
import 'package:cyr/providers/statistic/patient_statistic_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';

// 卒中人数统计
class RecentYearPatientChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Consumer<PatientStatisticProvider>(
        builder: (_, provider, __) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SfCartesianChart(
                  title: ChartTitle(
                      text: "卒中人数与死亡人数",
                      textStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                  primaryXAxis: CategoryAxis(),
                  legend:
                      Legend(isVisible: true, position: LegendPosition.bottom),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: [
                    ColumnSeries<PatientStatisticModel, String>(
                      xAxisName: "月份",
                      yAxisName: "数量",
                      name: "卒中人数",
                      dataSource: provider.list.reversed.toList(),
                      xValueMapper: (PatientStatisticModel data, _) =>
                          "${data.month}月",
                      yValueMapper: (PatientStatisticModel data, _) =>
                          data.patientsCount,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                    ColumnSeries<PatientStatisticModel, String>(
                      xAxisName: "月份",
                      yAxisName: "数量",
                      name: "死亡数",
                      dataSource: provider.list.reversed.toList(),
                      xValueMapper: (PatientStatisticModel data, _) =>
                          "${data.month}月",
                      yValueMapper: (PatientStatisticModel data, _) =>
                          data.deathCount,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ]),
              SfCartesianChart(
                  title: ChartTitle(
                      text: "死亡率",
                      textStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                  primaryXAxis: CategoryAxis(),
                  legend:
                      Legend(isVisible: true, position: LegendPosition.bottom),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: [
                    LineSeries<PatientStatisticModel, String>(
                      xAxisName: "月份",
                      yAxisName: "数量",
                      name: "死亡率",
                      dataSource: provider.list.reversed.toList(),
                      xValueMapper: (PatientStatisticModel data, _) =>
                          "${data.month}月",
                      yValueMapper: (PatientStatisticModel data, _) {
                        if(data.deathCount == null || data.patientsCount==null){
                          return 0;
                        }
                        return double.parse(
                            (data.deathCount ?? 0 / data.patientsCount ?? 1)
                                .toStringAsFixed(2));
                      },
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ]),
            ],
          );
        },
      ),
    );
  }
}

// DNT统计
class RecentYearDNTChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Consumer<PatientStatisticProvider>(
        builder: (_, provider, __) {
          return SfCartesianChart(
              title: ChartTitle(
                  text: "DNT统计",
                  textStyle: TextStyle(fontSize: 12, color: Colors.grey)),
              primaryXAxis: CategoryAxis(),
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: [
                LineSeries<PatientStatisticModel, String>(
                  xAxisName: "月份",
                  yAxisName: "数量",
                  name: "DNT平均时长(min)",
                  dataSource: provider.list.reversed.toList(),
                  xValueMapper: (PatientStatisticModel data, _) =>
                      "${data.month}月",
                  yValueMapper: (PatientStatisticModel data, _) =>
                      data.dntAverageTime,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
                ColumnSeries<PatientStatisticModel, String>(
                  xAxisName: "月份",
                  yAxisName: "数量",
                  name: "DNT超时数",
                  dataSource: provider.list.reversed.toList(),
                  xValueMapper: (PatientStatisticModel data, _) =>
                      "${data.month}月",
                  yValueMapper: (PatientStatisticModel data, _) =>
                      data.dntTimeOutCount,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ]);
        },
      ),
    );
  }
}

// 溶栓量血管内治疗
class EVTAndIVCTChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Consumer<PatientStatisticProvider>(
        builder: (_, provider, __) {
          return SfCartesianChart(
              title: ChartTitle(
                  text: "溶栓与血管内治疗",
                  textStyle: TextStyle(fontSize: 12, color: Colors.grey)),
              primaryXAxis: CategoryAxis(),
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: [
                ColumnSeries<PatientStatisticModel, String>(
                  xAxisName: "月份",
                  yAxisName: "数量",
                  name: "静脉溶栓数",
                  dataSource: provider.list.reversed.toList(),
                  xValueMapper: (PatientStatisticModel data, _) =>
                      "${data.month}月",
                  yValueMapper: (PatientStatisticModel data, _) =>
                      data.ivctCount,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
                ColumnSeries<PatientStatisticModel, String>(
                  xAxisName: "月份",
                  yAxisName: "数量",
                  name: "血管内治疗数",
                  dataSource: provider.list.reversed.toList(),
                  xValueMapper: (PatientStatisticModel data, _) =>
                      "${data.month}月",
                  yValueMapper: (PatientStatisticModel data, _) =>
                      data.evtCount,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ]);
        },
      ),
    );
  }
}
