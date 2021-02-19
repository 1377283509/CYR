import 'package:cyr/models/model_list.dart';
import 'package:cyr/models/record/ivct.dart';
import 'package:cyr/models/record/risk_assessment.dart';
import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/material.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:provider/provider.dart';

class IVCTProvider extends ChangeNotifier {
  final String visitRecordId;
  IVCTProvider(this.visitRecordId);

  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();

  IVCTModel _ivctModel;
  IVCTModel get ivctModel => _ivctModel;

  String get doctorId => _ivctModel?.doctorId;
  DateTime get startWitting => _ivctModel?.startWitting;
  DateTime get endWitting => _ivctModel?.endWitting;
  DateTime get startTime => _ivctModel?.startTime;
  DateTime get endTime => _ivctModel?.endTime;

  String get beforeNIHSS => _ivctModel?.beforeNIHSS;
  String get afterNIHSS => _ivctModel?.afterNIHSS;

  // 不良反应
  String get adverseReaction => _ivctModel?.adverseReaction;
  // 用药信息
  String get medicineInfo => _ivctModel?.medicineInfo;
  // 风险评估
  RiskAssessmentModel get riskAssessment => _ivctModel?.riskAssessment;

  // 根据就诊记录获取详情
  Future<void> getIVCT(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ivct", {
        "\$url": "getByVisitRecordId",
        "visitRecordId": visitRecordId,
      });
      if (res.data["code"] == 1) {
        _ivctModel = IVCTModel.fromJson(res.data["data"]["ivct"]);
        RiskAssessmentModel riskAssessmentModel =
            RiskAssessmentModel.fromJson(res.data["data"]["risk"]);
        _ivctModel.riskAssessment = riskAssessmentModel;
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      showToast(e.toString(), context);
    }
  }

  // 更新风险评估
  Future<void> setRiskAssessment(
      BuildContext context, RiskAssessmentModel riskAssessment) async {
    Doctor doctor = Provider.of<DoctorProvider>(context, listen: false).user;
    _ivctModel.riskAssessment = riskAssessment;
    notifyListeners();
    print(_ivctModel.riskAssessment.id);
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ivct", {
        "\$url": "setRiskAssessment",
        "riskAssessment": riskAssessment.toJson(),
        "riskAssessmentId": _ivctModel.riskAssessment.id,
        "id": _ivctModel.id,
        "doctorId": doctor.idCard,
        "doctorName": doctor.name
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ivctModel.riskAssessment = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ivctModel.riskAssessment = null;
      notifyListeners();
    }
  }

  // 更新开始知情
  Future<void> setStartWitting(BuildContext context) async {
    _ivctModel.startWitting = DateTime.now();
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ivct", {
        "\$url": "setStartWitting",
        "startWitting": _ivctModel.startWitting.toIso8601String(),
        "id": _ivctModel.id,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ivctModel.startWitting = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ivctModel.startWitting = null;
      notifyListeners();
    }
  }

  // 更新签署知情
  Future<void> setEndWitting(BuildContext context) async {
    _ivctModel.endWitting = DateTime.now();
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ivct", {
        "\$url": "setEndWitting",
        "endWitting": _ivctModel.endWitting.toIso8601String(),
        "id": _ivctModel.id,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ivctModel.endWitting = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ivctModel.endWitting = null;
      notifyListeners();
    }
  }

  // 更新前NIHSS评分
  Future<void> setBeforeNIHSS(BuildContext context, String result) async {
    _ivctModel.beforeNIHSS = result;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ivct", {
        "\$url": "setBeforeNIHSS",
        "beforeNIHSS": result,
        "id": _ivctModel.id,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ivctModel.beforeNIHSS = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ivctModel.beforeNIHSS = null;
      notifyListeners();
    }
  }

  // 更新后NIHSS评分
  Future<void> setAfterNIHSS(BuildContext context, String result) async {
    _ivctModel.afterNIHSS = result;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ivct", {
        "\$url": "setAfterNIHSS",
        "afterNIHSS": result,
        "id": _ivctModel.id,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ivctModel.afterNIHSS = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ivctModel.afterNIHSS = null;
      notifyListeners();
    }
  }

  // 更新溶栓开始时间
  Future<void> setStartTime(BuildContext context) async {
    _ivctModel.startTime = DateTime.now();
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ivct", {
        "\$url": "setStartTime",
        "startTime": _ivctModel.startTime.toIso8601String(),
        "id": _ivctModel.id,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ivctModel.startTime = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ivctModel.startTime = null;
      notifyListeners();
    }
  }

  // 更新用药信息
  Future<void> setMedicineInfo(BuildContext context, String result) async {
    _ivctModel.medicineInfo = result;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ivct", {
        "\$url": "setMedicineInfo",
        "medicineInfo": _ivctModel.medicineInfo,
        "id": _ivctModel.id,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ivctModel.medicineInfo = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ivctModel.medicineInfo = null;
      notifyListeners();
    }
  }

  // 更新不良反应
  Future<void> setAdverseReaction(BuildContext context, String result) async {
    _ivctModel.adverseReaction = result;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ivct", {
        "\$url": "setAdverseReaction",
        "adverseReaction": _ivctModel.adverseReaction,
        "id": _ivctModel.id,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ivctModel.adverseReaction = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ivctModel.adverseReaction = null;
      notifyListeners();
    }
  }

  // 更新完成时间
  Future<void> setEndTime(BuildContext context) async {
    _ivctModel.endTime = DateTime.now();
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ivct", {
        "\$url": "setEndTime",
        "endTime": _ivctModel.endTime.toIso8601String(),
        "id": _ivctModel.id,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ivctModel.endTime = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ivctModel.endTime = null;
      notifyListeners();
    }
  }
}
