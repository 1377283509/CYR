import 'package:cyr/pages/stat_page/widgets/monthly_patient.dart';
import 'package:cyr/pages/stat_page/widgets/recent_year_patient.dart';
import 'package:cyr/providers/statistic/patient_statistic_provider.dart';
import 'package:cyr/widgets/title/sub_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 统计页
class PatientStatPage extends StatelessWidget {
  _appBar(BuildContext context) {
    return AppBar(
      title: Text("患者数据统计", style: Theme.of(context).textTheme.headline1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: ChangeNotifierProvider(
          create: (BuildContext context) => PatientStatisticProvider(),
          child: PatientStatPageBody(),
        ));
  }
}

class PatientStatPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Provider.of<PatientStatisticProvider>(context)
          .getStatisticData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data) {
            return Center(
              child: Text("暂无数据, 每月初统计上一月数据"),
            );
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 12,
                ),
                SubTitle(
                  title: "月数据统计",
                  showMore: false,
                ),
                MonthlyPatientChart(),
                SizedBox(
                  height: 12,
                ),
                SubTitle(
                  title: "卒中人数统计",
                  showMore: false,
                ),
                RecentYearPatientChart(),
                SizedBox(
                  height: 12,
                ),
                SubTitle(
                  title: "DNT统计",
                  showMore: false,
                ),
                RecentYearDNTChart(),
                SizedBox(
                  height: 12,
                ),
                SubTitle(
                  title: "溶栓与血管内治疗统计",
                  showMore: false,
                ),
                EVTAndIVCTChart(),
              ],
            ),
          );
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
