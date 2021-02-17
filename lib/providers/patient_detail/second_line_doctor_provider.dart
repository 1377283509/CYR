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
  // 二线医生
  String get secondDoctorName => _secondLineDoctor?.secondDoctorName;
  String get secondDoctorId => _secondLineDoctor?.secondDoctorId;

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

  // 更新到达时间
  Future<void> setArriveTime(
      BuildContext context, String doctorId, String doctorName) async {
    _secondLineDoctor.secondDoctorName = doctorName;
    _secondLineDoctor.secondDoctorId = doctorId;
    _secondLineDoctor.arriveTime = DateTime.now();
    notifyListeners();
    try {
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("second-line-doctor", {
        "\$url": "setArriveTime",
        "id": _secondLineDoctor.id,
        "arriveTime": _secondLineDoctor.arriveTime.toIso8601String(),
        "secondDoctorId": doctorId,
        "secondDoctorName": doctorName,
      });
      if (res.data["code"] != 1) {
        _secondLineDoctor.secondDoctorName = null;
        _secondLineDoctor.secondDoctorId = null;
        _secondLineDoctor.arriveTime = null;
        showToast(res.data["data"], context);
      }
    } catch (e) {
      _secondLineDoctor.secondDoctorName = null;
      _secondLineDoctor.secondDoctorId = null;
      _secondLineDoctor.arriveTime = null;
      showToast(e.toString(), context);
    }
  }
}
