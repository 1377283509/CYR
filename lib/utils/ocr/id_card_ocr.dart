import 'dart:convert';
import 'dart:io';
import 'package:cyr/config.dart';
import 'package:cyr/models/model_list.dart';
import 'package:cyr/utils/dialog/show_dialog.dart';
import 'package:cyr/utils/pick_image/pick_image.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tencent_ocr/flutter_tencent_ocr.dart';
import 'package:flutter_tencent_ocr/IDCardOCR.dart';

// 识别身份证
Future<IDCard> idCardOCR(BuildContext context) async {
  File image = await pickImage(true);
  print(CloudConfig.tencentOCRSecretKey);
  print(CloudConfig.tencentOCRSecretId);
  IDCardOCRResponse res = await FlutterTencentOcr.iDCardOCR(
    CloudConfig.tencentOCRSecretId,
    CloudConfig.tencentOCRSecretKey,
    IDCardOCRRequest.fromParams(
        config: IDCardOCRConfig.fromParams(reshootWarn: true),
        imageBase64:
            base64Encode(image.readAsBytesSync().buffer.asUint8List())),
  );
  if (res.error != null) {
    showAlertDialog(context, res.error.message, "身份证识别结果");
    return null;
  }
  List<String> birthInfo = res.birth.split("/");
  DateTime birth = DateTime(int.parse(birthInfo[0]), int.parse(birthInfo[1]),
      int.parse(birthInfo[2]));
  int age = calculateAge(birth);
  IDCard idCard = IDCard(
      id: res.idNum,
      name: res.name,
      gender: res.sex,
      age: age,
      address: res.address);
  return idCard;
}
