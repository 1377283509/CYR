// 患者统计
import 'package:cyr/models/model_list.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class PatientStatisticProvider extends ChangeNotifier {
  List<PatientStatisticModel> list = [];
  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();

  // 获取近12个月数据
  Future<void> getStatisticData(BuildContext context) async {
    if(list.isNotEmpty){
      return;
    }
    try{
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("statistic", {
        "\$url": "getYearPatientData"
      });
      if(res.data["code"] == 1){
        list = [];
        res.data["data"].forEach((e)=>{
          list.add(PatientStatisticModel.fromJson(e))
        });
      }else{
        showToast(res.data["data"], context);
      }
    }catch(e){
      showToast("加载失败", context);
      print(e);
    }
  }
}
