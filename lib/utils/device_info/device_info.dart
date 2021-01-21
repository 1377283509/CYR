import 'dart:io';
import 'package:device_info/device_info.dart';

// 获取设备唯一ID
Future<String> getDeviceCode()async{
  DeviceInfoPlugin plugin = DeviceInfoPlugin();
  String code;
  if(Platform.isAndroid){
    AndroidDeviceInfo info = await plugin.androidInfo;
    code =  info.androidId;
  }else if(Platform.isIOS){
    IosDeviceInfo info = await plugin.iosInfo;
    code = info.identifierForVendor;
  }
  return code;
}

Future<String> getDeviceName()async{
  DeviceInfoPlugin plugin = DeviceInfoPlugin();
  String name;
  if(Platform.isAndroid){
    AndroidDeviceInfo info = await plugin.androidInfo;
    name =  info.model;
  }else if(Platform.isIOS){
    IosDeviceInfo info = await plugin.iosInfo;
    name = info.name;
  }
  return name;
}