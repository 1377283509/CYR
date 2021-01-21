import 'package:cyr/models/record/mRS.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class MRSProvider extends ChangeNotifier{
  final String visitRecordId;
  MRSProvider(this.visitRecordId);

  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();

  MRSModel _mrsModel;
  MRSModel get mrsModel => _mrsModel;

  String get result => _mrsModel?.result;
  DateTime get endTime => _mrsModel?.endTime;

  Future<void> getNIHSS(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("mrs", {
        "\$url": "getByVisitRecordId",
        "visitRecordId": visitRecordId,
      });
      if (res.data["code"] == 1) {
        _mrsModel = MRSModel.fromJson(res.data["data"]);
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }

  Future<void> setResult(
      BuildContext context,DateTime startTime, String doctorId, String doctorName, String result) async {
    _mrsModel.startTime = startTime;
    _mrsModel.doctorId = doctorId;
    _mrsModel.endTime = DateTime.now();
    _mrsModel.doctorName = doctorName;
    _mrsModel.result = result;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("mrs", {
        "\$url": "updateResult",
        "id": _mrsModel.id,
        "startTime": _mrsModel.startTime.toIso8601String(),
        "endTime": _mrsModel.endTime.toIso8601String(),
        "doctorId": _mrsModel.doctorId,
        "doctorName": _mrsModel.doctorName,
        "result": result,
      });
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
        _mrsModel.startTime = null;
        _mrsModel.doctorId = null;
        _mrsModel.endTime = null;
        _mrsModel.doctorName = null;
        _mrsModel.result = null;
        notifyListeners();
        return;
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _mrsModel.startTime = null;
      _mrsModel.doctorId = null;
      _mrsModel.endTime = null;
      _mrsModel.doctorName = null;
      _mrsModel.result = null;
      notifyListeners();
    }
  }
}