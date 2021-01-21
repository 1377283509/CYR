// 时间信息
import 'dart:async';
import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Consumer<VisitRecordProvider>(
              builder: (_, provider, __) {
                return TimeInfo(
                  title: "发病时长",
                  startTime: provider.diseaseTime,
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Consumer<VisitRecordProvider>(
              builder: (_, provider, __) {
                return TimeInfo(
                  title: "到院时长",
                  startTime: provider.visitTime,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TimeInfo extends StatefulWidget {
  final DateTime startTime;
  final String title;
  TimeInfo({@required this.title, @required this.startTime});

  @override
  _TimeInfoState createState() => _TimeInfoState();
}

class _TimeInfoState extends State<TimeInfo> {
  StreamController<int> _streamController;
  Timer _timer;

  int calculateSeconds() {
    if (widget.startTime == null) return 0;
    return widget.startTime.difference(DateTime.now()).inSeconds.abs();
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController.broadcast();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _streamController.add(calculateSeconds());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.title, style: TextStyle(
            fontSize: 16,
            letterSpacing: 3
          ),),
          SizedBox(height: 8,),
          StreamBuilder<int>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                return Text(
                  "${(snapshot.data ?? 0) ~/ 60} : ${(snapshot.data ?? 0) % 60}",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                );
              }),
        ],
      ),
    );
  }
}
