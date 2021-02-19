import 'package:cyr/models/record/laboratory_examination.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/material.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class LaboratoryExaminationProvider extends ChangeNotifier{

  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();
  final String visitRecordId;

  LaboratoryExaminationProvider(this.visitRecordId);

  LaboratoryExamination _laboratoryExamination;
  LaboratoryExamination get laboratoryExamination=>_laboratoryExamination;

  DateTime get endTime => _laboratoryExamination?.endTime;
  DateTime get arriveLaboratoryTime => _laboratoryExamination?.arriveLaboratoryTime;
  DateTime get bloodTime => _laboratoryExamination?.bloodTime;
  String get examinationDoctorId => _laboratoryExamination?.examinationDoctorId;
  String get drawBloodDoctorId => _laboratoryExamination?.drawBloodDoctorId;
  List<String> get images => _laboratoryExamination?.images ?? [];

  // 通过就诊记录获取化验检查详情
  Future<void> getByVisitRecord(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("laboratory-examination", {
        "\$url": "getByVisitRecordId",
        "visitRecordId": visitRecordId,
      });
      if (res.data["code"] == 1) {
        _laboratoryExamination = LaboratoryExamination.fromJson(res.data["data"]);
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }

  // 开始抽血
  Future<void> startDrawBlood(BuildContext context, String doctorId, String doctorName) async {
    _laboratoryExamination.bloodTime = DateTime.now();
    _laboratoryExamination.drawBloodDoctorId =doctorId;
    _laboratoryExamination.drawBloodDoctorName =doctorName;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("laboratory-examination", {
        "\$url": "startDrawBlood",
        "id": _laboratoryExamination.id,
        "bloodTime": _laboratoryExamination.bloodTime.toIso8601String(),
        "drawBloodDoctorId": _laboratoryExamination.drawBloodDoctorId,
        "drawBloodDoctorName": _laboratoryExamination.drawBloodDoctorName,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _laboratoryExamination.bloodTime = null;
        _laboratoryExamination.drawBloodDoctorId =null;
        _laboratoryExamination.drawBloodDoctorName =null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _laboratoryExamination.bloodTime = null;
      _laboratoryExamination.drawBloodDoctorId =null;
      _laboratoryExamination.drawBloodDoctorName =null;
      notifyListeners();
    }
  }

  // 到达化验室
  Future<void> setArriveTime(BuildContext context, String doctorId, String doctorName) async {
    _laboratoryExamination.arriveLaboratoryTime = DateTime.now();
    _laboratoryExamination.examinationDoctorId = doctorId;
    _laboratoryExamination.examinationDoctorName = doctorName;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("laboratory-examination", {
        "\$url": "setArriveTime",
        "id": _laboratoryExamination.id,
        "arriveLaboratoryTime": _laboratoryExamination.arriveLaboratoryTime.toIso8601String(),
        "examinationDoctorId": _laboratoryExamination.examinationDoctorId,
        "examinationDoctorName": _laboratoryExamination.examinationDoctorName,
      });
      print(res);
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _laboratoryExamination.arriveLaboratoryTime = null;
        _laboratoryExamination.examinationDoctorId = null;
        _laboratoryExamination.examinationDoctorName = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _laboratoryExamination.arriveLaboratoryTime = null;
      _laboratoryExamination.examinationDoctorId = null;
      _laboratoryExamination.examinationDoctorName = null;
      notifyListeners();
    }
  }

  // 更新结束时间
  Future<void> setEndTime(BuildContext context) async {
    _laboratoryExamination.endTime = DateTime.now();
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("laboratory-examination", {
        "\$url": "setEndTime",
        "id": _laboratoryExamination.id,
        "endTime": _laboratoryExamination.endTime.toIso8601String()
      });
      print(res);
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _laboratoryExamination.endTime = null;
        notifyListeners();
      }
    } catch (e) {
      showToast(e.toString(), context);
      _laboratoryExamination.endTime = null;
      notifyListeners();
    }
  }
}