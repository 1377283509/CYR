import 'dart:typed_data';
import 'package:cyr/utils/qr_code/qr_code_util.dart';
import 'package:flutter/material.dart';

Future<void> showQrCode(BuildContext context, String id)async{
  Uint8List res = await generateQrCode(id);
  showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: 24, vertical: 24),
          alignment: Alignment.center,
          child: Image.memory(res),
        );
      });
}