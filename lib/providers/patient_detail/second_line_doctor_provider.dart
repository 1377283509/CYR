import 'package:cyr/models/doctor/doctor_model.dart';
import 'package:cyr/models/record/second_line_doctor.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class SecondLineDoctorProvider extends ChangeNotifier {
  final String visitRecordId;
  SecondLineDoctorProvider(this.visitRecordId);

  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();
  SecondLineDoctorModel _secondLineDoctor;

  List<Doctor> _secondLineDoctors = [];
  List<Doctor> get secondLineDoctors => _secondLineDoctors;

  // 通知时间
  DateTime get notificationTime => _secondLineDoctor?.notificationTime;
  // 到达时间
  DateTime get arriveTime => _secondLineDoctor?.arriveTime;
  String get secondDoctorName => _secondLineDoctor?.secondDoctorName;
  String get secondDoctorId => _secondLineDoctor?.secondDoctorId;

  // 责任医生
  String get doctorName => _secondLineDoctor?.doctorName;
  String get doctorId => _secondLineDoctor?.doctorId;

  // 获取二线信息
  Future<void> getSecondLineInfo(BuildContext context) async {
    try {
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("second-line-doctor", {
        "\$url": "getByVisitRecordId",
        "visitRecordId": visitRecordId,
      });
      if (res.data["code"] == 1) {
        _secondLineDoctor = SecondLineDoctorModel.fromJson(res.data["data"]);
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }

  // 获取二线医生列表
  Future<void> getSecondLineDoctors(BuildContext context) async {
    if (_secondLineDoctors.isEmpty) {
      try {
        CloudBaseResponse res =
            await _cloudBaseUtil.callFunction("second-line-doctor", {
          "\$url": "getSecondLineDoctors",
        });
        if (res.data["code"] == 1) {
          res.data["data"]
              .forEach((e) => {_secondLineDoctors.add(Doctor.fromJson(e))});
          notifyListeners();
        } else {
          showToast(res.data["data"], context);
        }
      } catch (e) {
        showToast(e.toString(), context);
      }
    }
  }

  // 更新通知时间
  // [doctorId] && [doctorName]: 责任医生ID和姓名
  Future<void> setNotificationTime(BuildContext context, String doctorId, String doctorName)async{
    _secondLineDoctor.doctorName = doctorName;
    _secondLineDoctor.doctorId = doctorId;
    _secondLineDoctor.notificationTime = DateTime.now();
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("second-line-doctor", {
        "\$url": "setNotificationTime",
        "id": _secondLineDoctor.id,
        "notificationTime": _secondLineDoctor.notificationTime.toIso8601String(),
        "doctorId": doctorId,
        "doctorName": doctorName
      });
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
      }
    }catch(e){
      print(e.toString());
      showToast(e.toString(), context);
    }
  }

  // 更新到达时间
  Future<void> setArriveTime(BuildContext context, String doctorId, String doctorName)async{
    _secondLineDoctor.secondDoctorName = doctorName;
    _secondLineDoctor.secondDoctorId = doctorId;
    _secondLineDoctor.arriveTime = DateTime.now();
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("second-line-doctor", {
        "\$url": "setArriveTime",
        "id": _secondLineDoctor.id,
        "arriveTime": _secondLineDoctor.notificationTime.toIso8601String(),
        "secondDoctorId": doctorId,
        "secondDoctorName": doctorName,
      });
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
      }
    }catch(e){
      print(e.toString());
      showToast(e.toString(), context);
    }
  }
}
