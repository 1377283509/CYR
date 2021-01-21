import 'package:cyr/models/model_list.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class VitalSignsProvider extends ChangeNotifier {
  // 所属就诊记录ID
  final String visitRecordId;
  VitalSignsProvider(this.visitRecordId);

  // 生命体征
  VitalSignsModel _vitalSigns;
  VitalSignsModel get vitalSigns => _vitalSigns;
  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();

  String get bloodSugar => _vitalSigns?.bloodSugar;
  String get bloodPressure => _vitalSigns?.bloodPressure;
  String get weight => _vitalSigns?.weight;
  DateTime get startTime => _vitalSigns?.startTime;
  DateTime get endTime => _vitalSigns?.endTime;

  // 获取生命体征信息
  Future<void> getVitalSigns(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("vital-signs", {
        "\$url": "getByVisitRecordId",
        "visitRecordId": visitRecordId,
      });
      if (res.data["code"] == 1) {
        _vitalSigns = VitalSignsModel.fromJson(res.data["data"]);
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }

  //更新开始时间、责任医生
  Future<void> setDoctor(
      BuildContext context, String doctorId, String doctorName) async {
    DateTime startTime = DateTime.now();
    _vitalSigns.startTime = startTime;
    _vitalSigns.doctorId = doctorId;
    _vitalSigns.doctorName = doctorName;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("vital-signs", {
        "\$url": "setDoctor",
        "startTime": startTime.toIso8601String(),
        "id": _vitalSigns.id,
        "doctorId": doctorId,
        "doctorName": doctorName,
      });
      print(res);
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
        _vitalSigns.startTime = null;
        _vitalSigns.doctorId = null;
        _vitalSigns.doctorName = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _vitalSigns.startTime = null;
      _vitalSigns.doctorId = null;
      _vitalSigns.doctorName = null;
      notifyListeners();
    }
  }

  // 更新血糖信息
  Future<void> setBloodSugar(BuildContext context, String value) async {
    _vitalSigns.bloodSugar = value;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("vital-signs", {
        "\$url": "setBloodSugar",
        "id": _vitalSigns.id,
        "bloodSugar": value
      });
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
        _vitalSigns.bloodSugar = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _vitalSigns.bloodSugar = null;
      notifyListeners();
    }
  }

  // 更新血压信息
  Future<void> setBloodPressure(BuildContext context, String value)async{
    _vitalSigns.bloodPressure = value;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("vital-signs", {
        "\$url": "setBloodPressure",
        "id": _vitalSigns.id,
        "bloodPressure": value
      });
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
        _vitalSigns.bloodPressure = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _vitalSigns.bloodPressure = null;
      notifyListeners();
    }
  }

  // 更新体重信息
  Future<void> setWeight(BuildContext context, String value)async{
    _vitalSigns.weight = value;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("vital-signs", {
        "\$url": "setWeight",
        "id": _vitalSigns.id,
        "weight": value
      });
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
        _vitalSigns.weight = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _vitalSigns.weight = null;
      notifyListeners();
    }
  }

  // 更新结束时间
  Future<void> setEndTime(BuildContext context) async {
    DateTime endTime = DateTime.now();
    _vitalSigns.endTime = endTime;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("vital-signs", {
        "\$url": "setEndTime",
        "id":_vitalSigns.id,
        "endTime": endTime.toIso8601String()
      });
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
        _vitalSigns.endTime = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _vitalSigns.endTime = null;
      notifyListeners();
    }
  }
}
