import 'package:cyr/pages/page_list.dart';
import 'package:cyr/utils/navigator/custom_navigator.dart';
import 'package:cyr/utils/qr_code/qr_code_util.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QrScanButton extends StatelessWidget {

  _scan(BuildContext context) async {
    try{
      String res = await scan();
      navigateTo(context,PatientDetailPage(bangle: res,),);
    }catch(e){
     showToast("扫描失败", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.qr_code_scanner),
      onPressed: ()async{
        await _scan(context);
      },
    );
  }
}
