import 'package:cyr/models/model_list.dart';
import 'package:cyr/models/record/evt.dart';
import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/material.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:provider/provider.dart';

class EVTProvider extends ChangeNotifier {
  final String visitRecordId;
  EVTProvider(this.visitRecordId);

  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();

  EVTModel _evtModel;
  EVTModel get evtModel => _evtModel;
  DateTime get endTime => _evtModel?.endTime;
  DateTime get startWitting => _evtModel?.startWitting;
  DateTime get endWitting => _evtModel?.endWitting;
  DateTime get arriveTime => _evtModel?.arriveTime;
  DateTime get startTime => _evtModel?.startTime;
  DateTime get assetsTime => _evtModel?.assetsTime;
  DateTime get punctureTime => _evtModel?.punctureTime;
  DateTime get radiographyTime => _evtModel?.radiographyTime;
  DateTime get revascularizationTime => _evtModel?.revascularizationTime;
  String get wittingUtil => _evtModel?.wittingUtil;
  String get beforeNIHSS => _evtModel?.beforeNIHSS;
  String get methods => _evtModel?.methods;
  String get mTICI => _evtModel?.mTICI;
  String get result => _evtModel?.result;
  String get afterNIHSS => _evtModel?.afterNIHSS;
  String get adverseReaction => _evtModel?.adverseReaction;
  String get doctorId => _evtModel?.doctorId;
  String get doctorName => _evtModel?.doctorName;
  bool get onlyRadiography => _evtModel?.onlyRadiography;

  // 获取血管内治疗详情
  Future<void> getByVisitRecord(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "getByVisitRecordId",
        "visitRecordId": visitRecordId,
      });
      if (res.data["code"] == 1) {
        _evtModel = EVTModel.fromJson(res.data["data"]);
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }

  // 更新开始知情时间
  Future<void> setStartWitting(BuildContext context)async{
    _evtModel.startWitting = DateTime.now();
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setStartWitting",
        "id": _evtModel.id,
        "startWitting": _evtModel.startWitting.toIso8601String(),
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.startWitting = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.startWitting = null;
      notifyListeners();
    }
  }

  // 更新签署知情时间
  Future<void> setEndWitting(BuildContext context)async{
    _evtModel.endWitting = DateTime.now();
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setEndWitting",
        "id": _evtModel.id,
        "endWitting": _evtModel.endWitting.toIso8601String(),
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.endWitting = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.endWitting = null;
      notifyListeners();
    }
  }

  // 更新前NIHSS评分
  Future<void> setBeforeNIHSS(BuildContext context, String result)async{
    _evtModel.beforeNIHSS = result;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setBeforeNIHSS",
        "id": _evtModel.id,
        "beforeNIHSS": result,
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.beforeNIHSS = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.beforeNIHSS = null;
      notifyListeners();
    }
  }

  // 更新后NIHSS评分
  Future<void> setAfterNIHSS(BuildContext context, String result)async{
    _evtModel.afterNIHSS = result;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setAfterNIHSS",
        "id": _evtModel.id,
        "afterNIHSS": result,
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.afterNIHSS = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.afterNIHSS = null;
      notifyListeners();
    }
  }

  // 更新到达手术室大门时间
  Future<void> setArriveTime(BuildContext context)async{
    _evtModel.arriveTime = DateTime.now();
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setArriveTime",
        "id": _evtModel.id,
        "arriveTime": _evtModel.arriveTime.toIso8601String(),
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.arriveTime = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.arriveTime = null;
      notifyListeners();
    }
  }

  // 更新手术开始时间
  Future<void> setStartTime(BuildContext context)async{
    _evtModel.startTime = DateTime.now();
    notifyListeners();
    Doctor doctor = Provider.of<DoctorProvider>(context, listen: false).user;
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setStartTime",
        "id": _evtModel.id,
        "startTime": _evtModel.startTime.toIso8601String(),
        "doctorId": doctor.idCard,
        "doctorName": doctor.name
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.startTime = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.startTime = null;
      notifyListeners();
    }
  }

  // 更新责任血管评估完成时间
  Future<void> setAssetsTime(BuildContext context)async{
    _evtModel.assetsTime = DateTime.now();
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setAssetsTime",
        "id": _evtModel.id,
        "assetsTime": _evtModel.assetsTime.toIso8601String(),
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.assetsTime = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.assetsTime = null;
      notifyListeners();
    }
  }

  // 更新开始穿刺时间
  Future<void> setPunctureTime(BuildContext context)async{
    _evtModel.punctureTime = DateTime.now();
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setPunctureTime",
        "id": _evtModel.id,
        "punctureTime": _evtModel.punctureTime.toIso8601String(),
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.punctureTime = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.punctureTime = null;
      notifyListeners();
    }
  }

  // 更新造影完成时间
  Future<void> setRadiographyTime(BuildContext context)async{
    _evtModel.radiographyTime = DateTime.now();
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setRadiographyTime",
        "id": _evtModel.id,
        "radiographyTime": _evtModel.radiographyTime.toIso8601String(),
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.radiographyTime = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.radiographyTime = null;
      notifyListeners();
    }
  }

  // 更新是否仅造影
  Future<void> setOnlyRadiography(BuildContext context, bool onlyRadiography)async{
    _evtModel.onlyRadiography = onlyRadiography;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setOnlyRadiography",
        "id": _evtModel.id,
        "onlyRadiography": _evtModel.onlyRadiography,
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.onlyRadiography = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.onlyRadiography = null;
      notifyListeners();
    }
  }

  // 更新是否仅造影
  Future<void> setMethods(BuildContext context, String result)async{
    _evtModel.methods = result;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setMethods",
        "id": _evtModel.id,
        "methods": result,
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.methods = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.methods = null;
      notifyListeners();
    }
  }

  // 更新造影完成时间
  Future<void> setRevascularizationTime(BuildContext context)async{
    _evtModel.revascularizationTime = DateTime.now();
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setRevascularizationTime",
        "id": _evtModel.id,
        "revascularizationTime": _evtModel.revascularizationTime.toIso8601String(),
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.revascularizationTime = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.revascularizationTime = null;
      notifyListeners();
    }
  }

  // 更新手术完成时间
  Future<void> setEndTime(BuildContext context) async {
    _evtModel.endTime = DateTime.now();
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setEndTime",
        "id": _evtModel.id,
        "endTime": _evtModel.endTime.toIso8601String(),
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.endTime = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.endTime = null;
      notifyListeners();
    }
  }

  // 更新mTICI分级
  Future<void> setMTICI(BuildContext context, String result) async {
    _evtModel.mTICI = result;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setMTICI",
        "id": _evtModel.id,
        "mTICI": result,
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.mTICI = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.mTICI = null;
      notifyListeners();
    }
  }

  // 更新治疗结果
  Future<void> setResult(BuildContext context, String result) async {
    _evtModel.result = result;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setResult",
        "id": _evtModel.id,
        "result": result,
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.result = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.result = null;
      notifyListeners();
    }
  }

  Future<void> setAdverseReaction(BuildContext context, String result) async {
    _evtModel.adverseReaction = result;
    notifyListeners();
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("evt", {
        "\$url": "setAdverseReaction",
        "id": _evtModel.id,
        "adverseReaction": result,
      });
      if(res.data["code"]!=1){
        showToast(res.data["data"], context);
        _evtModel.adverseReaction = null;
        notifyListeners();
      }
    }catch(e){
      print(e);
      showToast(e.toString(), context);
      _evtModel.adverseReaction = null;
      notifyListeners();
    }
  }



}
