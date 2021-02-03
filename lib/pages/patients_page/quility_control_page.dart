import 'package:cyr/models/record/time_point.dart';
import 'package:cyr/providers/patient_detail/quility_control_provider.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuilityControlPage extends StatelessWidget {
  final String id;
  QuilityControlPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("质控"),
        actions: [
          TextButton(
            child: Text(
              "单位：min",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder<TimePointModel>(
        future: Provider.of<QuilityControlProvider>(context)
            .getTimePointData(context, id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return QuilityControlBody(snapshot.data);
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}

class QuilityControlBody extends StatelessWidget {
  final TimePointModel timePointModel;
  QuilityControlBody(this.timePointModel);
  // 顶部指示条
  _buildTopIndicator() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: _buildIndicator("标准时间范围", Colors.green),
          ),
          Expanded(
            flex: 1,
            child: _buildIndicator("超出时间范围", Colors.red),
          ),
        ],
      ),
    );
  }

  // 单个指示条
  _buildIndicator(String title, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 颜色区域
        Container(
          width: 24,
          height: 8,
          margin: EdgeInsets.only(right: 8),
          color: color,
        ),
        // 文字说明
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: _buildTopIndicator(),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            flex: 3,
            child: CenterList(timePointModel),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            flex: 12,
            child: TimePointList(timePointModel),
          )
        ],
      ),
    );
  }
}

class CenterItemModel {
  final int time;
  final String title;
  final String subtitle;
  final int referTime;
  CenterItemModel({this.title, this.subtitle, this.time, this.referTime});
}

class TimePointItemModel {
  final String startTitle;
  final DateTime startTime;
  final DateTime endTime;
  final String endTitle;
  final int referTime;

  TimePointItemModel(
      {this.startTime,
      this.startTitle,
      this.endTitle,
      this.endTime,
      this.referTime});
}

class CenterList extends StatelessWidget {
  final TimePointModel timePointModel;
  CenterList(this.timePointModel);

  @override
  Widget build(BuildContext context) {
    List list = []
      ..add(CenterItemModel(
          title: "DNT",
          subtitle: "到院 - 溶栓",
          time: calculateTime(
              timePointModel.arriveTime, timePointModel.ivctStartTime),
          referTime: timePointModel.dnt))
      ..add(CenterItemModel(
          title: "ONT",
          subtitle: "发病 - 溶栓",
          time: calculateTime(
              timePointModel.diseaseTime, timePointModel.ivctStartTime),
          referTime: timePointModel.ont))
      ..add(CenterItemModel(
          title: "ODT",
          subtitle: "发病 - 到院",
          time: calculateTime(
              timePointModel.diseaseTime, timePointModel.arriveTime),
          referTime: timePointModel.odt))
      ..add(CenterItemModel(
          title: "DPT",
          subtitle: "到院 - 穿刺",
          time: calculateTime(
              timePointModel.arriveTime, timePointModel.punctureTime),
          referTime: timePointModel.dpt))
      ..add(CenterItemModel(
          title: "DRT",
          subtitle: "到院 - 再通",
          time: calculateTime(
              timePointModel.arriveTime, timePointModel.revascularizationTime),
          referTime: timePointModel.drt));
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: list.map((e) => CenterItem(centerItemModel: e)).toList(),
      ),
    );
  }
}

class CenterItem extends StatelessWidget {
  final CenterItemModel centerItemModel;

  CenterItem({@required this.centerItemModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              centerItemModel.time == -1?" — ":"${centerItemModel.time}",
              style: TextStyle(
                  color: centerItemModel.time > centerItemModel.referTime?Colors.red:Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Text(
            centerItemModel.title,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            centerItemModel.subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

class TimePointList extends StatelessWidget {
  final TimePointModel timePointModel;
  TimePointList(this.timePointModel);
  @override
  Widget build(BuildContext context) {
    List<TimePointItemModel> list = []
      ..add(TimePointItemModel(
        startTitle: "就诊时间",
        endTitle: "CT完成时间",
        startTime: timePointModel.visitTime,
        endTime: timePointModel.ctFinishedTime,
      ))
      ..add(TimePointItemModel(
        startTitle: "CT完成时间",
        endTitle: "溶栓开始知情时间",
        startTime: timePointModel.ctFinishedTime,
        endTime: timePointModel.ivctStartWittingTime,
      ))
      ..add(TimePointItemModel(
        startTitle: "就诊时间",
        endTitle: "CTA完成时间",
        startTime: timePointModel.visitTime,
        endTime: timePointModel.radiographyTime,
      ))
      ..add(TimePointItemModel(
        startTitle: "溶栓知情开始时间",
        endTitle: "溶栓签署知情时间",
        startTime: timePointModel.ivctStartWittingTime,
        endTime: timePointModel.ivctEndWittingTime,
      ))
      ..add(TimePointItemModel(
          startTitle: "就诊时间",
          startTime: timePointModel.visitTime,
          endTime: timePointModel.ivctEndWittingTime,
          endTitle: "溶栓签署知情时间"))
      ..add(TimePointItemModel(
          startTitle: "就诊时间",
          startTime: timePointModel.visitTime,
          endTitle: "溶栓开始时间",
          endTime: timePointModel.ivctStartTime,
          referTime: timePointModel.dnt))
      ..add(TimePointItemModel(
        startTitle: "穿刺时间",
        startTime: timePointModel.punctureTime,
        endTitle: "血管再通时间",
        endTime: timePointModel.revascularizationTime,
      ))
      ..add(TimePointItemModel(
        startTitle: "溶栓开始时间",
        startTime: timePointModel.ivctStartTime,
        endTitle: "最后正常时间",
        endTime: timePointModel.diseaseTime,
      ))
      ..add(TimePointItemModel(
          startTitle: "最后正常时间",
          endTitle: "溶栓开始时间",
          startTime: timePointModel.diseaseTime,
          endTime: timePointModel.ivctStartTime))
      ..add(TimePointItemModel(
          startTitle: "血管内治疗开始知情时间",
          endTitle: "造影完成时间",
          startTime: timePointModel.evtStartWittingTime,
          endTime: timePointModel.radiographyTime));

    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return TimePointItem(list[index]);
        },
      ),
    );
  }
}

class TimePointItem extends StatelessWidget {
  final TimePointItemModel timePointItemModel;
  TimePointItem(this.timePointItemModel);

  Widget _buildLeft() {
    return Container(
      child: Column(
        children: [
          _buildTimeInfo(
              timePointItemModel.startTitle, timePointItemModel.startTime),
          Icon(
            Icons.arrow_downward,
            color: Colors.green.withOpacity(0.3),
          ),
          _buildTimeInfo(
              timePointItemModel.endTitle, timePointItemModel.endTime),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(String title, DateTime time) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            formatTime(time),
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildRight() {
    int time =
        calculateTime(timePointItemModel.startTime, timePointItemModel.endTime);
    Color color = Colors.grey;
    if (timePointItemModel.startTime != null &&
        timePointItemModel.endTime != null) {
      color = (timePointItemModel.referTime ?? 99999) > time
          ? Colors.green
          : Colors.red;
    }

    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              "时长",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              time == -1?" — ":"$time",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Colors.white70,
            indent: 24,
            endIndent: 24,
            height: 6,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "参考: ${timePointItemModel.referTime ?? ' — '} min",
              style: TextStyle(color: Colors.white.withOpacity(0.9)),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _buildLeft(),
          ),
          Expanded(
            flex: 1,
            child: _buildRight(),
          ),
        ],
      ),
    );
  }
}
