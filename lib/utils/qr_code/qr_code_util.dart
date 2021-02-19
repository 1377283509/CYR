import 'dart:typed_data';
import 'package:cyr/pages/qr_scan_page/qr_scan_page.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as qrscan;

// 扫码
Future<String> scan(BuildContext context) async {
  try {
    // String res = await qrscan.scan();
    String res = await navigateTo(context, ScanPage());
    print(res);
    return res;
  } catch (e) {
    return null;
  }
}

// 生成二维码
Future<Uint8List> generateQrCode(String content) async {
  Uint8List res = await qrscan.generateBarCode(content);
  return res;
}
