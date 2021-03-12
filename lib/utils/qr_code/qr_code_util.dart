import 'package:cyr/pages/qr_scan_page/qr_scan_page.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/material.dart';

// 扫码
Future<String> scan(BuildContext context) async {
  try {
    List<String> res = await navigateTo(context, ScanPage());
    if (res == null || res.length == 0) return null;
    return res[0];
  } catch (e) {
    print(e);
  }
  return null;
}
