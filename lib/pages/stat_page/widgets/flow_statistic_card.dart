import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/stat_page/flow_details_page.dart';
import 'package:cyr/providers/statistic/flow_statistic_provider.dart';
import 'package:cyr/utils/navigator/custom_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// 流程时长统计
class FlowStatisticCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Consumer<FlowStatisticProvider>(
        builder: (_, provider, __) {
          return Column(
            children: [
              SfCartesianChart(
                  title: ChartTitle(
                      text: "时长统计(秒)",
                      textStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                  primaryXAxis: CategoryAxis(),
                  legend:
                      Legend(isVisible: false, position: LegendPosition.bottom),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: [
                    BarSeries<RecordStatisticModel, String>(
                        name: "耗时(秒)",
                        dataSource: provider.monthData,
                        xValueMapper: (RecordStatisticModel data, _) =>
                            "${data.title}",
                        yValueMapper: (RecordStatisticModel data, _) =>
                            data.averageTime,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                        ),
                        sortingOrder: SortingOrder.ascending,
                        sortFieldValueMapper: (RecordStatisticModel data, _) =>
                            data.averageTime),
                  ]),
              SfCircularChart(
                  title: ChartTitle(
                      text: "时长占比",
                      textStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: [
                    DoughnutSeries<RecordStatisticModel, String>(
                      name: "耗时(秒)",
                      dataSource: provider.monthData,
                      xValueMapper: (RecordStatisticModel data, _) =>
                          "${data.title}",
                      yValueMapper: (RecordStatisticModel data, _) =>
                          data.averageTime,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                      ),
                    ),
                  ]),
            ],
          );
        },
      ),
    );
  }
}

// 流程时长表格
class FlowStatisticTable extends StatefulWidget {
  @override
  _FlowStatisticTableState createState() => _FlowStatisticTableState();
}

class _FlowStatisticTableState extends State<FlowStatisticTable> {
  bool _sortAscending = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<FlowStatisticProvider>(
      builder: (_, provider, __) {
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: CupertinoScrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: _sortAscending,
                  sortColumnIndex: 0,
                  dividerThickness: 0.5,
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.indigo.withOpacity(0.3)),
                  columns: [
                    DataColumn(
                        label: Container(child: Text("超时率")),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) {
                          _sortAscending = ascending;
                          if (ascending) {
                            provider.monthData.sort((RecordStatisticModel a,
                                    RecordStatisticModel b) =>
                                (a.totalCount == 0
                                        ? 0
                                        : a.overTimeCount / a.totalCount)
                                    .compareTo((b.totalCount == 0
                                        ? 0
                                        : b.overTimeCount / b.totalCount)));
                          } else {
                            provider.monthData.sort((RecordStatisticModel a,
                                    RecordStatisticModel b) =>
                                (b.totalCount == 0
                                        ? 0
                                        : b.overTimeCount / b.totalCount)
                                    .compareTo((a.totalCount == 0
                                        ? 0
                                        : a.overTimeCount / a.totalCount)));
                          }
                          setState(() {});
                        }),
                    DataColumn(label: Container(child: Text("流程名"))),
                    DataColumn(label: Container(child: Text("总数"))),
                    DataColumn(label: Container(child: Text("超时数"))),
                    DataColumn(label: Container(child: Text("平均用时"))),
                    DataColumn(label: Container(child: Text("月份"))),
                  ],
                  rows: provider.monthData
                      .map((e) => DataRow(cells: [
                            DataCell(
                              Text(
                                e.totalCount == 0
                                    ? "0%"
                                    : "${(e.overTimeCount * 100 / e.totalCount).toStringAsFixed(2)}%",
                                style: TextStyle(color: Colors.red[800]),
                              ),
                            ),
                            DataCell(TextButton(
                              child: Text(e.title),
                              onPressed: () {
                                navigateTo(context, FlowDetailsPage(type: e.flowRecord));
                              },
                            )),
                            DataCell(Text("${e.totalCount}")),
                            DataCell(Text("${e.overTimeCount}")),
                            DataCell(Text(
                                "${e.averageTime ~/ 60}分${e.averageTime % 60}秒")),
                            DataCell(Text("${e.year}年${e.month}月")),
                          ]))
                      .toList()),
            ),
          ),
        );
      },
    );
  }
}
