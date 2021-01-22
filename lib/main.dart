import 'package:cyr/config.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'models/model_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 读取云相关配置
  CloudConfig.init().then((value) async {
    // 获取医护人员信息
    Doctor doctor = await CloudBaseUtil().getDoctor();
    runApp(MyApp(
      user: doctor,
    ));
  });
}
