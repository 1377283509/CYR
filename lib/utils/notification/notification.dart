import 'dart:typed_data';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../pages/patients_page/patient_detail.dart';
import '../../app.dart';

class CustomNotification {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static final CustomNotification _instance = CustomNotification._internal();

  factory CustomNotification() => _instance;

  CustomNotification._internal() {
    if (_flutterLocalNotificationsPlugin == null) {
      init();
    }
  }

  // 初始化
  void init() {
    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var androidSettings =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = new IOSInitializationSettings();
    var initSettings =
        new InitializationSettings(android: androidSettings, iOS: iOSSettings);
    _flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: navToDetail);
  }

  // 发送通知
  send(int idx, String id, String name, String content,
      DateTime sendTime) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        "notification", "消息通知", "",
        sound: RawResourceAndroidNotificationSound("notification"),
        playSound: true,
        enableVibration: true,
        vibrationPattern: Int64List.fromList([3000]));
    var android = new AndroidNotificationDetails(
        channel.id, channel.name, channel.description,
        priority: Priority.max,
        importance: Importance.max,
        vibrationPattern: channel.vibrationPattern,
        sound: channel.sound,
        fullScreenIntent: true);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await _flutterLocalNotificationsPlugin.show(
        0,
        content,
        "$name  ${formatTime(sendTime, format: TimeFormatType.MONTH_DAY_HOUR_MINUTE)}",
        platform,
        payload: "$id-$name");
  }

  // 导航到详情页
  Future navToDetail(String payload) {
    List<String> args = payload.split("-");
    var context = navigatorKey.currentState.overlay.context;
    print(context);
    return navigatorKey.currentState.push(CupertinoPageRoute(
        builder: (BuildContext context) =>
            PatientDetailPage(id: args[0],)));
  }
}
