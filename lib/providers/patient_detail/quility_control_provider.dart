import 'package:cyr/models/record/time_point.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class QuilityControlProvider extends ChangeNotifier{
  
  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();

  Future<TimePointModel> getTimePointData(BuildContext context, String visitRecordId)async{
    TimePointModel timePointModel;
    try {
      CloudBaseResponse res = await _cloudBaseUtil.callFunction("visit-record", {
        "\$url": "getTimePointData",
        "id": visitRecordId
      });

      if(res.data["code"] == 1){
        timePointModel = TimePointModel.fromJson(res.data["data"]);
      }else{
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
    }
    return timePointModel;
  }

}
