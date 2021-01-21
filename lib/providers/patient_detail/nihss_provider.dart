import 'package:cyr/models/record/nihss.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class NIHSSProvider extends ChangeNotifier{
  final String visitRecordId;
  NIHSSProvider(this.visitRecordId);

  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();

  NIHSSModel _nihssModel;
  NIHSSModel get nihssModel => _nihssModel;

  String get result => _nihssModel?.result;
  DateTime get endTime => _nihssModel?.endTime;
  DateTime get startTime => _nihssModel?.startTime;

  // 获取NIHSS信息
  Future<void> getNIHSS(BuildContext context) async {
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("nihss", {
        "\$url": "getByVisitRecordId",
        "visitRecordId": visitRecordId,
      });
      if (res.data["code"] == 1) {
        _nihssModel = NIHSSModel.fromJson(res.data["data"]);
        notifyListeners();
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }

  // 更新结果
  Future<void> setResult(
      BuildContext context,DateTime startTime, String doctorId, String doctorName, String result) async {
    _nihssModel.startTime = startTime;
    _nihssModel.doctorId = doctorId;
    _nihssModel.endTime = DateTime.now();
    _nihssModel.doctorName = doctorName;
    _nihssModel.result = result;
    notifyListeners();
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("nihss", {
        "\$url": "updateResult",
        "id": _nihssModel.id,
        "startTime": _nihssModel.startTime.toIso8601String(),
        "endTime": _nihssModel.endTime.toIso8601String(),
        "doctorId": _nihssModel.doctorId,
        "doctorName": _nihssModel.doctorName,
        "result": result,
      });
      if(res.data["code"] != 1){
        showToast(res.data["data"], context);
        _nihssModel.startTime = null;
        _nihssModel.doctorId = null;
        _nihssModel.endTime = null;
        _nihssModel.doctorName = null;
        _nihssModel.result = null;
        notifyListeners();
        return;
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
      _nihssModel.startTime = null;
      _nihssModel.doctorId = null;
      _nihssModel.endTime = null;
      _nihssModel.doctorName = null;
      _nihssModel.result = null;
      notifyListeners();
    }
  }


}