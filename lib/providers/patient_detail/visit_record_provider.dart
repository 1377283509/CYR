// 就诊记录
import 'dart:async';

import 'package:cyr/models/model_list.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class VisitRecordProvider extends ChangeNotifier {
  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();

  VisitRecordModel _visitRecordModel;
  VisitRecordModel get visitRecordModel => _visitRecordModel;

  int _patientsCount;
  int get patientCount => _patientsCount;
  // 主治医生
  String get doctorId => _visitRecordModel?.doctorId;
  String get doctorName => _visitRecordModel?.doctorName;

  // 就诊时间
  DateTime get visitTime => _visitRecordModel?.visitTime;
  // 发病时间
  DateTime get diseaseTime => _visitRecordModel?.diseaseTime;
  // 到院时间
  DateTime get arriveTime => _visitRecordModel?.arriveTime;

  DateTime get createTime => _visitRecordModel?.createTime;

  // 手环
  String get bangle => _visitRecordModel?.bangle;

  // 是否进行缺血性脑卒中
  bool get isCI => _visitRecordModel?.isCI;

  // 是否TIA
  bool get isTIA => _visitRecordModel?.isTIA;

  // 是否进行血管内治疗
  bool get isEVT => _visitRecordModel?.isEVT;
  // 去向
  String get lastStep => _visitRecordModel?.lastStep;
  // 患者姓名
  String get patientName => _visitRecordModel?.patientName;

  // 获取就诊记录详情
  Future<bool> getVisitRecord(
      BuildContext context, String id, String bangle) async {
    try {
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("visit-record", {
        "\$url": id == null ? "getByBangle" : "getVisitRecordDetail",
        "id": id,
        "bangle": bangle,
      });
      if (res.data["code"] == 1) {
        _visitRecordModel = VisitRecordModel.fromJson(res.data["data"]);
        notifyListeners();
        return true;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      showToast(e.toString(), context);
    }
    return false;
  }

  // 绑定手环
  Future<void> setBangle(BuildContext context, String bangle) async {
    _visitRecordModel.bangle = bangle;
    _visitRecordModel.arriveTime = DateTime.now();
    notifyListeners();
    try {
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("visit-record", {
        "\$url": "bindBangle",
        "bangle": bangle,
        "id": _visitRecordModel.id,
        "arriveTime": _visitRecordModel.arriveTime.toIso8601String()
      });
      if (res.data["code"] != 1) {
        _visitRecordModel.bangle = null;
        _visitRecordModel.arriveTime = null;
        showToast(res.data["data"], context);
        notifyListeners();
      }
    } catch (e) {
      _visitRecordModel.bangle = null;
      _visitRecordModel.arriveTime = null;
      showToast(e.toString(), context);
    }
  }

  // 添加诊断结果
  Future<void> setVisitResult(BuildContext context, String result) async {
    try {
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("visit-record", {
        "\$url": "updateVisitResult",
        "id": _visitRecordModel.id,
        "result": result,
      });
      if (res.data["code"] == 1) {
        _visitRecordModel.result = result;
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }

  // 绑定主治医师
  Future<void> setDoctor(
      BuildContext context, String doctorId, String doctorName) async {
    // 本地更新doctor信息
    _visitRecordModel.doctorId = doctorId;
    _visitRecordModel.doctorName = doctorName;
    _visitRecordModel.visitTime = DateTime.now();
    notifyListeners();
    try {
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("visit-record", {
        "\$url": "setDoctor",
        "id": _visitRecordModel.id,
        "doctorId": doctorId,
        "doctorName": doctorName,
        "visitTime": _visitRecordModel.visitTime.toIso8601String(),
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _visitRecordModel.doctorId = null;
        _visitRecordModel.doctorName = null;
        _visitRecordModel.visitTime = null;
        notifyListeners();
      }
    } catch (e) {
      showToast(e.toString(), context);
      _visitRecordModel.doctorId = null;
      _visitRecordModel.doctorName = null;
      _visitRecordModel.visitTime = null;
      notifyListeners();
    }
  }

  // 更新TIA
  Future<void> setTIA(BuildContext context) async {
    _visitRecordModel.isTIA = !_visitRecordModel.isTIA;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("visit-record",
          {"\$url": "setTIA", "TIA": _visitRecordModel.isTIA, "id": _visitRecordModel.id});

      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _visitRecordModel.isTIA = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _visitRecordModel.isTIA = null;
      notifyListeners();
    }
  }

  // 更新缺血性脑卒中
  Future<void> setCI(BuildContext context) async {
    _visitRecordModel.isCI = !_visitRecordModel.isCI;
    notifyListeners();
    try {
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("visit-record", {
        "\$url": "setCI",
        "isCI": _visitRecordModel.isCI,
        "id": _visitRecordModel.id
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _visitRecordModel.isCI = !_visitRecordModel.isCI;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _visitRecordModel.isCI = !_visitRecordModel.isCI;
      notifyListeners();
    }
  }

  // 更新EVT
  Future<void> setEVT(BuildContext context) async {
    _visitRecordModel.isEVT = !_visitRecordModel.isEVT;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction(
          "visit-record", {
        "\$url": "setEVT",
        "isEVT": _visitRecordModel.isEVT,
        "id": _visitRecordModel.id
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _visitRecordModel.isEVT = !_visitRecordModel.isEVT;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _visitRecordModel.isEVT = !_visitRecordModel.isEVT;
      notifyListeners();
    }
  }

  // 更新去向
  Future<void> setLastStep(BuildContext context, String result) async {
    _visitRecordModel.lastStep = result;
    notifyListeners();
    try {
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("visit-record", {
        "\$url": "setLastStep",
        "lastStep": result,
        "endTime": DateTime.now().toIso8601String(),
        "id": _visitRecordModel.id
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _visitRecordModel.lastStep = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _visitRecordModel.lastStep = null;
      notifyListeners();
    }
  }


}
