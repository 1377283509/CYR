import 'package:cyr/models/record/CT.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/material.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class CTProvider extends ChangeNotifier {
  final String visitRecordId;
  CTProvider(this.visitRecordId);

  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();

  CTModel _ctModel;
  CTModel get ctModel => _ctModel;

  DateTime get orderTime => _ctModel?.orderTime;
  DateTime get arriveTime => _ctModel?.arriveTime;
  List<String> get images => _ctModel?.images ?? [];
  DateTime get endTime => _ctModel?.endTime;
  // 检查责任医生
  String get doctorId => _ctModel?.doctorId;

  // 根据VisitRecord加载CT信息
  Future<void> getCT(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ct", {
        "\$url": "getByVisitRecordId",
        "visitRecordId": visitRecordId,
      });
      if (res.data["code"] == 1) {
        _ctModel = CTModel.fromJson(res.data["data"]);
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }

  // 更新开单时间
  Future<void> setOrderTime(
      BuildContext context, String doctorId, String doctorName) async {
    _ctModel.orderTime = DateTime.now();
    _ctModel.orderDoctorId = doctorId;
    _ctModel.orderDoctorName = doctorName;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ct", {
        "\$url": "updateOrderTime",
        "id": _ctModel.id,
        "orderDoctorName": _ctModel.orderDoctorName,
        "orderDoctorId": _ctModel.orderDoctorId,
        "orderTime": _ctModel.orderTime.toIso8601String(),
      });
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
        _ctModel.orderTime = null;
        _ctModel.orderDoctorId = null;
        _ctModel.orderDoctorName = null;
        notifyListeners();
        return;
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _ctModel.orderTime = null;
      _ctModel.orderDoctorId = null;
      _ctModel.orderDoctorName = null;
      notifyListeners();
    }
  }

  // 更新到达时间
  Future<void> setArriveTime(
      BuildContext context, String doctorId, String doctorName) async {
    _ctModel.arriveTime = DateTime.now();
    _ctModel.doctorId = doctorId;
    _ctModel.doctorName = doctorName;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ct", {
        "\$url": "updateArriveTime",
        "id": _ctModel.id,
        "arriveTime": _ctModel.arriveTime.toIso8601String(),
        "doctorId": _ctModel.doctorId,
        "doctorName": _ctModel.doctorName,
      });
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
        _ctModel.arriveTime = null;
        _ctModel.doctorId = null;
        _ctModel.doctorName = null;
        notifyListeners();
        return;
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _ctModel.arriveTime = null;
      _ctModel.doctorId = null;
      _ctModel.doctorName = null;
      notifyListeners();
    }
  }

  // 更新图片
  Future<void> setImages(BuildContext context, List<String> images) async {
    _ctModel.images = images;
    _ctModel.endTime = DateTime.now();
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ct", {
        "\$url": "setImages",
        "id": _ctModel.id,
        "images": images,
        "endTime": _ctModel.endTime.toIso8601String()
      });
      print(res);
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ctModel.images = null;
        _ctModel.endTime = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _ctModel.images = null;
      _ctModel.endTime = null;
      notifyListeners();
    }
  }

}
