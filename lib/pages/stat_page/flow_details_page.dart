import 'package:cyr/models/model_list.dart';
import 'package:cyr/models/record/CT.dart';
import 'package:cyr/models/record/ECG.dart';
import 'package:cyr/models/record/evt.dart';
import 'package:cyr/models/record/ivct.dart';
import 'package:cyr/models/record/laboratory_examination.dart';
import 'package:cyr/models/record/mRS.dart';
import 'package:cyr/models/record/nihss.dart';
import 'package:cyr/models/record/second_line_doctor.dart';
import 'package:cyr/providers/statistic/flow_detail_provider.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/widgets/reocord/ct_card.dart';
import 'package:cyr/widgets/reocord/ecg_card.dart';
import 'package:cyr/widgets/reocord/evt_record.dart';
import 'package:cyr/widgets/reocord/ivct_card.dart';
import 'package:cyr/widgets/reocord/laboratory_examination.dart';
import 'package:cyr/widgets/reocord/mrs_card.dart';
import 'package:cyr/widgets/reocord/nihss_card.dart';
import 'package:cyr/widgets/reocord/second_line_doctor_card.dart';
import 'package:cyr/widgets/reocord/vital_signs_card.dart';
import 'package:cyr/widgets/title/sub_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'widgets/stat_card.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

class FlowDetailsPage extends StatelessWidget {
  final FlowRecord type;
  FlowDetailsPage({@required this.type});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        lazy: false,
        create: (BuildContext context) => FlowDetailsProvider(),
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(flowNames[type]),
            ),
            body: FlowDetailsPageBody(type)));
  }
}

class FlowDetailsPageBody extends StatelessWidget {
  final FlowRecord type;

  FlowDetailsPageBody(this.type);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<FlowDetailsProvider>(context)
            .getFlowDetailsData(context, type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  SubTitle(
                    title: "月数据",
                    showMore: false,
                  ),
                  MonthDataCard(),
                  SizedBox(
                    height: 12,
                  ),
                  SubTitle(
                    title: "超时列表",
                    moreText: "查看",
                    moreCallback: () {
                      showOverTimeList(context, type);
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SubTitle(
                    title: "近一年数据统计",
                    showMore: false,
                  ),
                  AverageYearlyTimeLineChart(),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        });
  }

  // 显示超时列表
  showOverTimeList(BuildContext context, FlowRecord type) {
    switch (type) {
      case FlowRecord.CT:
        {
          showCTList(context);
          break;
        }
      case FlowRecord.ECG:
        {
          showEcgList(context);
          break;
        }
      case FlowRecord.LaboratoryExamination:
        {
          showLEList(context);
          break;
        }
      case FlowRecord.SecondLine:
        {
          showSecondLineList(context);
          break;
        }
      case FlowRecord.VitalSigns:
        {
          showVitalSignsList(context);
          break;
        }
      case FlowRecord.NIHSS:
        {
          showNIHSSList(context);
          break;
        }
      case FlowRecord.MRS:
        {
          showMRSList(context);
          break;
        }
      case FlowRecord.IVCT:
        {
          showIVCTList(context);
          break;
        }
        case FlowRecord.EVT:
        {
          showEVTList(context);
          break;
        }
      default:
        {
          showToast("类型错误", context);
          break;
        }
    }
  }

  // CT超时列表
  showCTList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "CT超时列表",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.grey),
            ),
            body: FutureBuilder<List<CTModel>>(
              future:
                  Provider.of<FlowDetailsProvider>(scaffoldKey.currentContext)
                      .getCTOvertimeList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                      itemBuilder: (context, index) {
                        return CTCard(snapshot.data[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          );
        });
  }

  // ECG超时列表
  showEcgList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "心电图超时列表",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.grey),
            ),
            body: FutureBuilder<List<ECGModel>>(
              future:
                  Provider.of<FlowDetailsProvider>(scaffoldKey.currentContext)
                      .getECGOvertimeList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                      itemBuilder: (context, index) {
                        return ECGCard(snapshot.data[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          );
        });
  }

  // 化验检查超时列表
  showLEList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "化验检查超时列表",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.grey),
            ),
            body: FutureBuilder<List<LaboratoryExamination>>(
              future:
                  Provider.of<FlowDetailsProvider>(scaffoldKey.currentContext)
                      .getLEOvertimeList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                      itemBuilder: (context, index) {
                        return LaboratoryExaminationCard(snapshot.data[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          );
        });
  }

  // 二线超时列表
  showSecondLineList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "二线超时列表",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.grey),
            ),
            body: FutureBuilder<List<SecondLineDoctorModel>>(
              future:
                  Provider.of<FlowDetailsProvider>(scaffoldKey.currentContext)
                      .getSecondLineOvertimeList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                      itemBuilder: (context, index) {
                        return SecondLineDoctorCard(snapshot.data[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          );
        });
  }

  // 生命体征超时列表
  showVitalSignsList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "生命体征超时列表",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.grey),
            ),
            body: FutureBuilder<List<VitalSignsModel>>(
              future:
                  Provider.of<FlowDetailsProvider>(scaffoldKey.currentContext)
                      .getVitalSignsOvertimeList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                      itemBuilder: (context, index) {
                        return VitalSignsCard(snapshot.data[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          );
        });
  }

  // NIHSS评分超时列表
  showNIHSSList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "NIHSS评分超时列表",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.grey),
            ),
            body: FutureBuilder<List<NIHSSModel>>(
              future:
                  Provider.of<FlowDetailsProvider>(scaffoldKey.currentContext)
                      .getNIHSSOvertimeList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                      itemBuilder: (context, index) {
                        return NIHSSCard(snapshot.data[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          );
        });
  }

  // mRS评分超时列表
  showMRSList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "mRS评分超时列表",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.grey),
            ),
            body: FutureBuilder<List<MRSModel>>(
              future:
                  Provider.of<FlowDetailsProvider>(scaffoldKey.currentContext)
                      .getMRSOvertimeList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                      itemBuilder: (context, index) {
                        return MRSCard(snapshot.data[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          );
        });
  }

  // 静脉溶栓超时列表
  showIVCTList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "静脉溶栓超时列表",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.grey),
            ),
            body: FutureBuilder<List<IVCTModel>>(
              future:
                  Provider.of<FlowDetailsProvider>(scaffoldKey.currentContext)
                      .getIVCTOvertimeList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                      itemBuilder: (context, index) {
                        return IVCTCard(snapshot.data[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          );
        });
  }

  // 血管内治疗超时列表
  showEVTList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "血管内治疗超时列表",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.grey),
            ),
            body: FutureBuilder<List<EVTModel>>(
              future:
                  Provider.of<FlowDetailsProvider>(scaffoldKey.currentContext)
                      .getEVTOvertimeList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                      itemBuilder: (context, index) {
                        return EVTCard(snapshot.data[index]);
                      },
                    ),
                  );
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          );
        });
  }

}

// 近12个月的平均用时折线图
class AverageYearlyTimeLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Consumer<FlowDetailsProvider>(
          builder: (_, provider, __) {
            return Column(
              children: [
                // 总数、超时统计
                SfCartesianChart(
                    title: ChartTitle(
                        text: "整体数据",
                        textStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                    primaryXAxis: CategoryAxis(),
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: [
                      ColumnSeries<RecordStatisticModel, String>(
                        name: "总数",
                        dataSource: provider.flowDetail.reversed.toList(),
                        xValueMapper: (RecordStatisticModel data, _) =>
                            "${data.month}月",
                        yValueMapper: (RecordStatisticModel data, _) =>
                            data.totalCount,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                      ColumnSeries<RecordStatisticModel, String>(
                        name: "超时数",
                        dataSource: provider.flowDetail.reversed.toList(),
                        xValueMapper: (RecordStatisticModel data, _) =>
                            "${data.month}月",
                        yValueMapper: (RecordStatisticModel data, _) =>
                            data.overTimeCount,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                    ]),
                // 平均时长与超时率
                SfCartesianChart(
                    title: ChartTitle(
                        text: "平均时长与超时率",
                        textStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                    primaryXAxis: CategoryAxis(),
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: [
                      LineSeries<RecordStatisticModel, String>(
                        name: "平均耗时(秒)",
                        dataSource: provider.flowDetail.reversed.toList(),
                        xValueMapper: (RecordStatisticModel data, _) =>
                            "${data.month}月",
                        yValueMapper: (RecordStatisticModel data, _) =>
                            data.averageTime,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                      LineSeries<RecordStatisticModel, String>(
                        name: "超时率",
                        dataSource: provider.flowDetail.reversed.toList(),
                        xValueMapper: (RecordStatisticModel data, _) =>
                            "${data.month}月",
                        dataLabelMapper: (RecordStatisticModel data, _) =>
                            data.totalCount == 0
                                ? "0"
                                : (data.overTimeCount / data.totalCount)
                                    .toStringAsFixed(2),
                        yValueMapper: (RecordStatisticModel data, _) =>
                            data.totalCount == 0
                                ? 0
                                : data.overTimeCount * 300 / data.totalCount,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                    ]),
              ],
            );
          },
        ));
  }
}

// 上月数据
class MonthDataCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 12),
        child: Consumer<FlowDetailsProvider>(
          builder: (_, provider, __) {
            RecordStatisticModel monthData = provider.flowDetail.first;
            return Column(
              children: [
                Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    SquareCard(
                      title: "总数",
                      count: "${monthData.totalCount}人",
                      color: Colors.green,
                    ),
                    SquareCard(
                      title: "超时数",
                      count: "${monthData.overTimeCount} 人",
                      color: Colors.red,
                    ),
                    SquareCard(
                      title: "平均时长",
                      count:
                          "${monthData.averageTime ~/ 60}分${monthData.averageTime % 60}秒",
                      color: Colors.orange,
                    ),
                    SquareCard(
                      title: "超时率",
                      count:
                          "${monthData.totalCount == 0 ? "0" : (monthData.overTimeCount / monthData.totalCount).toStringAsFixed(2)}%",
                      color: Colors.blue,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  alignment: Alignment.center,
                  child: Text(
                    "${monthData.year} 年 ${monthData.month} 月",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
