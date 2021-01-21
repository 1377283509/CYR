import 'package:cyr/models/model_list.dart';
import 'package:cyr/models/record/CT.dart';
import 'package:cyr/models/record/ECG.dart';
import 'package:cyr/models/record/evt.dart';
import 'package:cyr/models/record/ivct.dart';
import 'package:cyr/models/record/laboratory_examination.dart';
import 'package:cyr/models/record/mRS.dart';
import 'package:cyr/models/record/nihss.dart';
import 'package:cyr/models/record/second_line_doctor.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class FlowDetailsProvider extends ChangeNotifier {
  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();
  List<RecordStatisticModel> _flowDetail = [];
  List<RecordStatisticModel> get flowDetail => _flowDetail;
  FlowRecord _curType;
  List<CTModel> _ctList = [];
  List<CTModel> get ctList => _ctList;

  List<ECGModel> _ecgList = [];
  List<ECGModel> get ecgList => _ecgList;

  List<LaboratoryExamination> _leList = [];
  List<LaboratoryExamination> get leList => _leList;

  List<SecondLineDoctorModel> _secondLineList = [];
  List<SecondLineDoctorModel> get secondLineList => _secondLineList;

  List<VitalSignsModel> _vitalSignsList = [];
  List<VitalSignsModel> get vitalSignsList => _vitalSignsList;

  List<NIHSSModel> _nihssList = [];
  List<NIHSSModel> get nihssList => _nihssList;

  List<MRSModel> _mrsList = [];
  List<MRSModel> get mrsList => _mrsList;
  
  List<IVCTModel> _ivctList = [];
  List<IVCTModel> get ivctList => _ivctList;

  List<EVTModel> _evtList = [];
  List<EVTModel> get evtList => _evtList;

  // 获取流程详细数据
  Future<void> getFlowDetailsData(BuildContext context, FlowRecord type) async {
    if (_curType == type && _flowDetail.isNotEmpty) {
      return;
    }
    _curType = type;
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction(
          "statistic", {"\$url": "getFlowDetailsData", "type": type.index});
      if (res.data["code"] == 1) {
        _flowDetail.clear();
        res.data["data"].forEach(
            (e) => {_flowDetail.add(RecordStatisticModel.fromJson(e, type))});
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // 获取CT超时列表
  Future<List<CTModel>> getCTOvertimeList(BuildContext context) async {
    if (_ctList != null && _ctList.isNotEmpty) {
      return _ctList;
    }
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("statistic", {
        "\$url": "getOverTimeList",
        "type": FlowRecord.CT.index,
        "id": _flowDetail.first.id
      });
      if (res.data["code"] == 1) {
        List<CTModel> list = [];
        res.data["data"].forEach((e) => list.add(CTModel.fromJson(e)));
        _ctList = list;
        return _ctList;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
    return [];
  }

  // 获取心电图超时列表
  Future<List<ECGModel>> getECGOvertimeList(BuildContext context) async {
    if (_ecgList != null && _ecgList.isNotEmpty) {
      return _ecgList;
    }
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("statistic", {
        "\$url": "getOverTimeList",
        "type": FlowRecord.ECG.index,
        "id": _flowDetail.first.id
      });
      if (res.data["code"] == 1) {
        List<ECGModel> list = [];
        res.data["data"].forEach((e) => list.add(ECGModel.fromJson(e)));
        _ecgList = list;
        return _ecgList;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
    return [];
  }

  // 获取化验检查超时列表
  Future<List<LaboratoryExamination>> getLEOvertimeList(
      BuildContext context) async {
    if (_leList != null && _leList.isNotEmpty) {
      return _leList;
    }
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("statistic", {
        "\$url": "getOverTimeList",
        "type": FlowRecord.LaboratoryExamination.index,
        "id": _flowDetail.first.id
      });
      if (res.data["code"] == 1) {
        List<LaboratoryExamination> list = [];
        res.data["data"]
            .forEach((e) => list.add(LaboratoryExamination.fromJson(e)));
        _leList = list;
        return _leList;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
    return [];
  }

  // 获取二线超时列表
  Future<List<SecondLineDoctorModel>> getSecondLineOvertimeList(
      BuildContext context) async {
    if (_secondLineList != null && _secondLineList.isNotEmpty) {
      return _secondLineList;
    }
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("statistic", {
        "\$url": "getOverTimeList",
        "type": FlowRecord.SecondLine.index,
        "id": _flowDetail.first.id
      });
      if (res.data["code"] == 1) {
        List<SecondLineDoctorModel> list = [];
        res.data["data"]
            .forEach((e) => list.add(SecondLineDoctorModel.fromJson(e)));
        _secondLineList = list;
        return _secondLineList;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
    return [];
  }

  // 获取生命体征超时列表
  Future<List<VitalSignsModel>> getVitalSignsOvertimeList(
      BuildContext context) async {
    if (_vitalSignsList != null && _vitalSignsList.isNotEmpty) {
      return _vitalSignsList;
    }
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("statistic", {
        "\$url": "getOverTimeList",
        "type": FlowRecord.VitalSigns.index,
        "id": _flowDetail.first.id
      });
      if (res.data["code"] == 1) {
        List<VitalSignsModel> list = [];
        res.data["data"].forEach((e) => list.add(VitalSignsModel.fromJson(e)));
        _vitalSignsList = list;
        return _vitalSignsList;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
    return [];
  }

  // 获取NIHSS超时列表
  Future<List<NIHSSModel>> getNIHSSOvertimeList(BuildContext context) async {
    if (_nihssList != null && _nihssList.isNotEmpty) {
      return _nihssList;
    }
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("statistic", {
        "\$url": "getOverTimeList",
        "type": FlowRecord.NIHSS.index,
        "id": _flowDetail.first.id
      });
      if (res.data["code"] == 1) {
        List<NIHSSModel> list = [];
        res.data["data"].forEach((e) => list.add(NIHSSModel.fromJson(e)));
        _nihssList = list;
        return _nihssList;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
    return [];
  }

  // 获取MRS评分超时列表
  Future<List<MRSModel>> getMRSOvertimeList(BuildContext context) async {
    if (_mrsList != null && _mrsList.isNotEmpty) {
      return _mrsList;
    }
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("statistic", {
        "\$url": "getOverTimeList",
        "type": FlowRecord.MRS.index,
        "id": _flowDetail.first.id
      });
      if (res.data["code"] == 1) {
        List<MRSModel> list = [];
        res.data["data"].forEach((e) => list.add(MRSModel.fromJson(e)));
        _mrsList = list;
        return _mrsList;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
    return [];
  }

 // 获取静脉溶栓评分超时列表
  Future<List<IVCTModel>> getIVCTOvertimeList(BuildContext context) async {
    if (_ivctList != null && _ivctList.isNotEmpty) {
      return _ivctList;
    }
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("statistic", {
        "\$url": "getOverTimeList",
        "type": FlowRecord.IVCT.index,
        "id": _flowDetail.first.id
      });
      if (res.data["code"] == 1) {
        List<IVCTModel> list = [];
        res.data["data"].forEach((e) => list.add(IVCTModel.fromJson(e)));
        _ivctList = list;
        return _ivctList;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
    return [];
  }

  // 获取血管内治疗超时列表
  Future<List<EVTModel>> getEVTOvertimeList(BuildContext context) async {
    if (_evtList != null && _evtList.isNotEmpty) {
      return _evtList;
    }
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("statistic", {
        "\$url": "getOverTimeList",
        "type": FlowRecord.EVT.index,
        "id": _flowDetail.first.id
      });
      if (res.data["code"] == 1) {
        List<EVTModel> list = [];
        res.data["data"].forEach((e) => list.add(EVTModel.fromJson(e)));
        _evtList = list;
        return _evtList;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
    return [];
  }



}
