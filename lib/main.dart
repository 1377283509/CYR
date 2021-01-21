import 'dart:io';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter/services.dart';
import 'models/model_list.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 获取用户信息
  Doctor doctor = await CloudBaseUtil().getDoctor();
  //设置Android状态栏透明
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  runApp(MyApp(
    user: doctor,
  ));
}
