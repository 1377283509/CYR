import 'dart:io';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:path_provider/path_provider.dart';

class FilesProvider extends ChangeNotifier {
  CloudBaseUtil _cloudBase;
  FilesProvider() {
    _cloudBase = CloudBaseUtil();
  }
  // 上传完成的
  List<UpLoad> _doneList = [];
  List<UpLoad> get doneList => _doneList;

  double _process;
  double get process => _process;

  // 反馈
  Future<bool> feedBack(String content, List<String> images) async {
    try {
      CloudBaseResponse res = await _cloudBase.callFunction("feed-back", {
        '\$url': "add",
        "content": content,
        "images": images,
      });
      if (res.data["code"] == 1) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  // 上传
  upLoadFile(File file) async {
    _doneList.add(UpLoad(0, file, ""));
    notifyListeners();
    UploadRes res = await _cloudBase.upLoadFile(file.path, (now, total) {
      _process = now / total;
      _doneList.last.process = _process;
      notifyListeners();
    });
    _doneList.last.fileId = res.fileId;
    notifyListeners();
  }

  // 清除images列表
  clearImageList() {
    _doneList.clear();
  }

  // 下载文件
  Future<File> downLoadImage(String fileId, BuildContext context) async {
    String fileName = fileId.split("/").last;
    Directory directory = await getExternalStorageDirectory();
    String path = directory.path + "/Pictures/" + fileName;
    try {
      File image = File(path);
      if(!image.existsSync()){
        await _cloudBase.downLoadFile(fileId,path,(now, total) {});
      }
      return File(path);
    } catch (e) {
      showToast("下载失败", context);
    }
    return null;
  }

  // 删除文件
  deleteFile(UpLoad file, BuildContext context) async {
    try {
      DeleteMetadata res = await _cloudBase.deleteFile([file.fileId]);
      if (res.code == "SUCCESS") {
        _doneList.remove(file);
        notifyListeners();
        showToast("成功删除", context);
      }
    } catch (e) {
      showToast("删除失败", context);
    }
  }

  // 获取所有图片id
  List<String> getFileIdList() {
    List<String> list = [];
    _doneList.forEach((element) {
      list.add(element.fileId);
    });
    return list;
  }

  @override
  void dispose() {
    super.dispose();
    _doneList.clear();
  }
}

class UpLoad {
  double process;
  File file;
  String fileId;
  UpLoad(this.process, this.file, this.fileId);
}
