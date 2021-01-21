import 'package:cyr/models/model_list.dart';
import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/utils/notification/notification.dart';
import 'package:cyr/widgets/message/message_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List _messages;
  RealtimeListener _realtimeListener;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  CustomNotification _notification;

  void addMessage(List list) async {
    setState(() {
      _messages = list;
    });
    list.forEach((element) {
      _notification.send(
          list.indexOf(element),
          element["visitRecord"],
          element["patientName"],
          element["content"],
          DateTime.parse(element["sendTime"]));
    });
  }

  @override
  void initState() {
    super.initState();
    _messages = [];
    // 初始化云环境
    _notification = CustomNotification();
    // 开启数据库监听
    String myId = Provider.of<DoctorProvider>(context, listen: false).user.id;
    _realtimeListener = CloudBaseUtil().db.collection("message").where({
      "to": myId,
      "state": false
    }).watch(
        onChange: (Snapshot snapshot) {
          addMessage(snapshot.docs);
        },
        onError: (error) {});
  }

  @override
  void dispose() {
    super.dispose();
    _realtimeListener.close();
  }

  @override
  Widget build(BuildContext context) {
    if(_messages.isEmpty){
      return Container(
        padding: const EdgeInsets.only(bottom: 24),
        alignment: Alignment.center,
        child: const Text("暂无新消息", style: TextStyle(
          color: Colors.grey,
          fontSize:13
        ),),
      );
    }
    return Column(
      children: _messages.map((e) => MessageCard(MessageModel.fromJson(e))).toList(),
    );
  }
}
