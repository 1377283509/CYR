import 'package:cyr/utils/util_list.dart';
import 'package:cyr/models/model_list.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class DoctorProvider extends ChangeNotifier {
  CloudBaseUtil _cloudBase;
  final Doctor user;
  DoctorProvider(this.user) {
    _cloudBase = CloudBaseUtil();
  }

  List _doctorList = [];
  List get doctorList => _doctorList;

  // 获取所有医护人员
  Future<void> getAllDoctors(BuildContext context) async {
    try{
      CloudBaseResponse res = await _cloudBase.callFunction("doctor", {
        "\$url": "getAllDoctors",
      });
      _doctorList = res.data["data"];
    }catch(e){
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
      if(result["code"] == 1){
        user.state = result["data"];
        notifyListeners();
      }else{
        showToast(result["data"], context);
      }
    } catch (e) {
      showToast("TCB异常", context);
    }
  }
}
