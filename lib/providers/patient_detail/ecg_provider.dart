import 'package:cyr/models/record/ECG.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class ECGProvider extends ChangeNotifier {
  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();
  // 所属就诊记录Id
  final String visitRecordId;
  ECGProvider(this.visitRecordId);

  ECGModel _ecgModel;
  ECGModel get ecgModel => _ecgModel;

  List<String> get images => _ecgModel?.images ?? [];

  DateTime get endTime => _ecgModel?.endTime;

  // 根据VisitRecord加载心电图信息
  Future<void> getECG(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ecg", {
        "\$url": "getByVisitRecordId",
        "visitRecordId": visitRecordId,
      });
      if (res.data["code"] == 1) {
        _ecgModel = ECGModel.fromJson(res.data["data"]);
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }

  // 更新开始时间、责任医生
  Future<void> setDoctor(
      BuildContext context, String doctorId, String doctorName) async {
    DateTime startTime = DateTime.now();
    _ecgModel.startTime = startTime;
    _ecgModel.doctorId = doctorId;
    _ecgModel.doctorName = doctorName;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ecg", {
        "\$url": "setDoctor",
        "startTime": startTime.toIso8601String(),
        "id": _ecgModel.id,
        "doctorId": doctorId,
        "doctorName": doctorName,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ecgModel.startTime = null;
        _ecgModel.doctorId = null;
        _ecgModel.doctorName = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ecgModel.startTime = null;
      _ecgModel.doctorId = null;
      _ecgModel.doctorName = null;
      notifyListeners();
    }
  }

  // 更新完成时间
  Future<void> setEndTime(BuildContext context) async {
    _ecgModel.endTime = DateTime.now();
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("ecg", {
        "\$url": "setEndTime",
        "endTime": _ecgModel.endTime.toIso8601String(),
        "id": _ecgModel.id,
      });
      if (res.data["code"] != 1) {
        showToast(res.data["data"], context);
        _ecgModel.endTime = null;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _ecgModel.endTime = null;
      notifyListeners();
    }
  }
}
