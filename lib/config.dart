// 云接口相关配置
import 'dart:convert';
import 'package:flutter/services.dart';

class CloudConfig {
  static String tencentOCRSecretKey;
  static String tencentOCRSecretId;
  static String tcbAndroidAccessKey;
  static String tcbAndroidAccessKeyVersion;
  static String tcbIOSAccessKey;
  static String tcbIOSAccessKeyVersion;
  static String tcbEnv;

  static Future<void> init() async {
    final String configString = await rootBundle.loadString("app_config.json");
    Map<String, dynamic> mapConfig = json.decode(configString);
    tencentOCRSecretId = mapConfig["tencentOCRSecretId"] as String;
    tcbAndroidAccessKeyVersion =
        mapConfig["tcbAndroidAccessKeyVersion"] as String;
    tcbAndroidAccessKey = mapConfig["tcbAndroidAccessKey"] as String;
    tcbEnv = mapConfig["tcbEnv"] as String;
    tcbIOSAccessKey = mapConfig["tcbIOSAccessKey"] as String;
    tcbIOSAccessKeyVersion = mapConfig["tcbIOSAccessKeyVersion"] as String;
    tencentOCRSecretKey = mapConfig["tencentOCRSecretKey"] as String;
  }
}
