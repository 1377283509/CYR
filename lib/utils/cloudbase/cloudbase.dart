import 'dart:io';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:cyr/config.dart';
import 'package:cyr/models/doctor/doctor_model.dart';
import '../util_list.dart';

class CloudBaseUtil {
  static final CloudBaseUtil _instance = CloudBaseUtil._internal();
  CloudBaseCore _core;
  CloudBaseCore get core => _core;

  CloudConfig _cloudConfig;
  CloudConfig get cloudConfig => _cloudConfig;

  CloudBaseAuth _auth;
  CloudBaseAuth get auth => _auth;

  CloudBaseFunction _cloud;
  CloudBaseFunction get cloud => _cloud;

  CloudBaseStorage _storage;
  CloudBaseStorage get storage => _storage;

  CloudBaseDatabase _db;
  CloudBaseDatabase get db => _db;

  Doctor _doctor;

  Future<Doctor> getDoctor() async {
    if (_doctor == null) {
      String res = await login();
      if (res != "SUCCESS") {
        return null;
      }
    }
    return _doctor;
  }

  factory CloudBaseUtil() => _instance;

  CloudBaseUtil._internal() {
    if (_core == null) {
      String accessKey = Platform.isAndroid
          ? CloudConfig.tcbAndroidAccessKey
          : CloudConfig.tcbIOSAccessKey;
      String accessKeyVersion = Platform.isAndroid
          ? CloudConfig.tcbAndroidAccessKeyVersion
          : CloudConfig.tcbIOSAccessKeyVersion;
      _core = CloudBaseCore.init({
        'env': CloudConfig.tcbEnv,
        'appAccess': {'key': accessKey, 'version': accessKeyVersion},
        'timeout': 3000
      });
      _auth = CloudBaseAuth(_core);
      _cloud = CloudBaseFunction(_core);
      _storage = CloudBaseStorage(_core);
      _db = CloudBaseDatabase(_core);
    }
  }

  Future<String> login() async {
    // 登录
    try {
      if (await _auth.getAuthState() == null) {
        await _auth.signInAnonymously();
      }
      String device = await getDeviceCode();
      CloudBaseResponse res = await _cloud
          .callFunction("doctor", {"\$url": "login", "device": device});
      Map result = Map.of(res.data);
      _doctor = Doctor.fromJson(result["data"]);
      return "SUCCESS";
    } catch (e) {
      return e.toString();
    }
  }

  // 调用云函数
  Future<CloudBaseResponse> callFunction(
      String name, Map<String, dynamic> params) async {
    return await _cloud.callFunction(name, params);
  }

  // 上传文件
  Future upLoadFile(String filePath, Function process) async {
    String cloudPath = "images/" + filePath.split("/").last;
    CloudBaseStorageRes<UploadRes> res = await _storage.uploadFile(
        cloudPath: cloudPath, filePath: filePath, onProcess: process);
    return res.data;
  }

  // 下载文件
  Future<void> downLoadFile(
      String fileId, String savePath, Function process) async {
    await _storage.downloadFile(
        fileId: fileId, savePath: savePath, onProcess: process);
  }

  // 删除文件
  Future<DeleteMetadata> deleteFile(List<String> ids) async {
    CloudBaseStorageRes<List<DeleteMetadata>> res =
        await _storage.deleteFiles(ids);
    return res.data.first;
  }
}
