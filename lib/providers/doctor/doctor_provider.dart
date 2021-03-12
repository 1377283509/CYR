import 'package:cyr/pages/home_page/home_page.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/models/model_list.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class DoctorProvider extends ChangeNotifier {
  CloudBaseUtil _cloudBase;
  Doctor user;
  DoctorProvider({this.user}) {
    _cloudBase = CloudBaseUtil();
    user = _cloudBase.doctor;
  }

  List _doctorList = [];
  List get doctorList => _doctorList;

  // 登录
  Future<void> login(
      BuildContext context, String username, String password) async {
    try {
      String deviceCode = await getDeviceCode();
      CloudBaseResponse res = await _cloudBase.callFunction("doctor", {
        "\$url": "login",
        "username": username,
        "password": password,
        "deviceCode": deviceCode
      });
      if (res.data["code"] == 1) {
        user = Doctor.fromJson(res.data["data"]);
        navigateReplacement(context, HomePage());
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      showToast("云函数调用失败", context);
    }
  }

  // 注册
  Future<void> register(
      BuildContext context,
      String name,
      String password,
      String department,
      String job,
      String gender,
      int age,
      String idCard,
      String phone) async {
    // 获取设备码
    String device = await getDeviceCode();

    try {
      CloudBaseResponse res = await _cloudBase.callFunction("doctor", {
        "\$url": "registe",
        "data": {
          "name": name,
          "gender": gender,
          "age": age,
          "department": department,
          "job": job,
          "password": password,
          "device": device,
          "idCard": idCard,
          "phone": phone
        }
      });
      if (res.data["code"] == 1) {
        user = Doctor(
            age: age,
            name: name,
            gender: gender,
            state: false,
            department: department,
            job: job,
            idCard: idCard,
            phone: phone);
        navigateReplacement(context, HomePage());
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {}
  }

  // 获取所有医护人员
  Future<void> getAllDoctors(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBase.callFunction("doctor", {
        "\$url": "getAllDoctors",
      });
      _doctorList = res.data["data"];
    } catch (e) {
      print(e);
      showToast("TCB异常", context);
    }
  }

  // 修改工作状态
  Future<void> changeState(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBase.callFunction("doctor", {
        "\$url": "changeWorkState",
        "idCard": user.idCard,
        "state": !user.state
      });
      Map result = Map.of(res.data);
      if (result["code"] == 1) {
        user.state = result["data"];
        notifyListeners();
      } else {
        showToast(result["data"], context);
      }
    } catch (e) {
      showToast("TCB异常", context);
    }
  }
}
