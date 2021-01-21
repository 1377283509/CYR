import 'package:cyr/models/model_list.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class FlowStatisticProvider extends ChangeNotifier {
  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();
  List<RecordStatisticModel> _monthData = [];
  List<RecordStatisticModel> get monthData => _monthData;

  // 初始化数据数据
  Future<void> initData(BuildContext context) async {
    if (_monthData.isNotEmpty) {
      return;
    }
    try {
      CloudBaseResponse res = await _cloudBaseUtil
          .callFunction("statistic", {"\$url": "getRecentMonthFlowData"});
      if (res.data["code"] == 1) {
        var data = res.data["data"];
        _monthData.add(RecordStatisticModel.fromJson(data["ct"], FlowRecord.CT));
        _monthData.add(RecordStatisticModel.fromJson(data["ecg"], FlowRecord.ECG));
        _monthData.add(RecordStatisticModel.fromJson(
            data["laboratoryExamination"], FlowRecord.LaboratoryExamination));
        _monthData
            .add(RecordStatisticModel.fromJson(data["secondLine"], FlowRecord.SecondLine));
        _monthData
            .add(RecordStatisticModel.fromJson(data["vitalSigns"], FlowRecord.VitalSigns));
        _monthData.add(RecordStatisticModel.fromJson(data["nihss"], FlowRecord.NIHSS));
        _monthData.add(RecordStatisticModel.fromJson(data["mRS"], FlowRecord.MRS));
        _monthData.add(RecordStatisticModel.fromJson(data["ivct"], FlowRecord.IVCT));
        _monthData.add(RecordStatisticModel.fromJson(data["evt"], FlowRecord.EVT));
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }
}
