import 'package:cyr/models/record/aspect.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class AspectProvider extends ChangeNotifier {
  final String visitRecordId;
  AspectProvider(this.visitRecordId);
  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();

  AspectModel _aspectModel;

  bool get state => _aspectModel?.state ?? false;
  String get result => _aspectModel?.result;
  int get totalScore => _aspectModel?.totalScore;
  int get score => _aspectModel?.score;

  DateTime get endTime => _aspectModel?.endTime;
  String get doctorName => _aspectModel?.doctorName;

  //根据就诊记录获取数据
  Future<void> getDataByVisitRecordId(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("aspect", {
        "\$url": "getByVisitRecordId",
        "visitRecordId": visitRecordId,
      });
      if (res.data["code"] == 1) {
        _aspectModel = AspectModel.fromJson(res.data["data"]);
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      showToast(e.toString(), context);
    }
  }

  // 更新结果
  Future<void> setResult(BuildContext context, AspectModel aspectModel) async {
    _aspectModel.endTime = aspectModel.endTime;
    _aspectModel.score = aspectModel.score;
    _aspectModel.totalScore = aspectModel.totalScore;
    _aspectModel.result = aspectModel.result;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("aspect", {
        "\$url": 'setResult',
        "id": _aspectModel.id,
        "startTime": aspectModel.startTime.toIso8601String(),
        "endTime": aspectModel.endTime.toIso8601String(),
        "totalScore": aspectModel.totalScore,
        "score": aspectModel.score,
        "result": aspectModel.result,
        "doctorId": aspectModel.doctorId,
        "doctorName": aspectModel.doctorName
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _aspectModel = null;
        notifyListeners();
      }
    } catch (e) {
      showToast(e.toString(), context);
      _aspectModel = null;
      notifyListeners();
    }
  }
}
