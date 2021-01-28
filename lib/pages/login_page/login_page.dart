import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 登录
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("卒中中心信息采集"),
        centerTitle: false,
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 45),
                  child: Text("信息未录入，请获取设备码，联系管理员录入数据。")),
              ElevatedButton(
                onPressed: () async {
                  String code = await getDeviceCode();
                  Clipboard.setData(ClipboardData(text: code));
                  showToast("设备码已复制到剪切板", context);
                },
                child: Text("获取设备码"),
              ),
            ],
          ))),
    );
  }
}
