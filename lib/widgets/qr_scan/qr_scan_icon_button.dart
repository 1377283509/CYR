import 'package:cyr/pages/page_list.dart';
import 'package:cyr/utils/navigator/custom_navigator.dart';
import 'package:cyr/utils/qr_code/qr_code_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QrScanButton extends StatelessWidget {
  _scan(BuildContext context) async {
    String res = await scan(context);
    if (res != null) {
      navigateTo(
        context,
        PatientDetailPage(
          bangle: res,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.qr_code_scanner),
      onPressed: () async {
        await _scan(context);
      },
    );
  }
}
