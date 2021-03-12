import 'dart:async';
import 'dart:io';
import 'package:cyr/pages/feed_back/feed_back.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/navigator/custom_navigator.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class VersionModel {
  String id;
  String version;
  String url;
  String description;
  DateTime date;
  String platform;

  VersionModel.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    version = json["version"];
    url = json["url"];
    description = json["description"];
    date = DateTime.fromMillisecondsSinceEpoch(json["date"]);
    platform = json["platform"];
  }
}

class AppInfoCard extends StatefulWidget {
  @override
  _AppInfoCardState createState() => _AppInfoCardState();
}

class _AppInfoCardState extends State<AppInfoCard> {
  bool isloading = false;

  // 获取版本信息
  Future<String> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  StreamController<double> dowloadProcess;

  // 检查更新
  Future<void> _checkUpdate() async {
    setState(() {
      isloading = true;
    });
    // 获取最新版本信息
    VersionModel versionModel = await getVersionInfo();
    if (versionModel != null) {
      // 获取当前版本信息
      String curVersion = await _getPackageInfo();
      // 判断版本是否一样
      // 版本信息一样
      if (versionModel.version == curVersion) {
        showToast("已是最新版", context);
        setState(() {
          isloading = false;
        });
        return;
      }
      int curVer = int.parse(curVersion.split(".").join(""));
      int ver = int.parse(versionModel.version.split(".").join());
      if (curVer > ver) {
        return;
      }
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              titlePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              title: ListTile(
                leading: FlutterLogo(
                  size: 24,
                ),
                title: Text("新版本"),
                subtitle: Text(versionModel.version),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                // 更新内容
                Text(versionModel.description ?? ""),
                // 更新时间
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "更新时间\n" + formatTime(versionModel.date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),

                StreamBuilder<double>(
                  stream: dowloadProcess.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(
                            (snapshot.data * 100).toStringAsFixed(1) + "%",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          LinearProgressIndicator(
                            value: snapshot.data,
                          ),
                        ],
                      );
                    } else {
                      return ElevatedButton(
                        child: Text("立即更新"),
                        onPressed: () async {
                          await doUpdate(versionModel);
                        },
                      );
                    }
                  },
                )
              ],
            );
          });
    }
    setState(() {
      isloading = false;
    });
  }

  // 执行更新
  Future<void> doUpdate(VersionModel versionModel) async {
    if (versionModel.platform == "android") {
      // 下载APK
      File apk = await dowloadAPK(versionModel);
      // 安装APK
      if (apk != null) {
        print(apk.path);
        await installAPK(apk);
      }
    } else {
      await launchUrl(versionModel.url);
    }
  }

  // 获取最新版本信息
  Future<VersionModel> getVersionInfo() async {
    String platform = Platform.isAndroid ? "android" : "ios";
    CloudBaseUtil cloudBaseUtil = CloudBaseUtil();
    var res = await cloudBaseUtil.db
        .collection("versions")
        .orderBy("date", "desc")
        .where({"platform": platform})
        .limit(1)
        .get();
    // 无版本信息
    if (res.data == null || res.data.length == 0) {
      showToast("无版本信息", context);
      return null;
    }
    // 有版本信息
    VersionModel versionModel = VersionModel.fromJson(res.data[0]);
    return versionModel;
  }

  // 下载APK
  Future<File> dowloadAPK(VersionModel versionModel) async {
    dowloadProcess.add(0);
    Directory storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir.path;
    String path = '$storagePath/cyrv${versionModel.version}.apk';
    // 不存在，创建
    if (!File(path).existsSync()) {
      try {
        await CloudBaseUtil().downLoadFile(versionModel.url, path,
            (now, total) {
          dowloadProcess.add(now / total);
        });
      } catch (e) {
        showToast("下载失败", context);
        return null;
      }
    }
    return File(path);
  }

  // 安装APK
  Future<void> installAPK(File apk) async {
    await OpenFile.open(apk.path);
  }

  @override
  void initState() {
    super.initState();
    _checkUpdate();
    dowloadProcess = StreamController.broadcast();
  }

  @override
  void dispose() {
    super.dispose();
    dowloadProcess.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.feedback,
              color: Colors.black54,
            ),
            onTap: () {
              navigateTo(
                  context,
                  ChangeNotifierProvider(
                      lazy: false,
                      create: (BuildContext context) => FilesProvider(),
                      child: FeedBackPage()));
            },
            title: const Text("功能反馈"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.cached,
              color: Colors.black54,
            ),
            title: const Text("检查更新"),
            onTap: () async {
              await _checkUpdate();
            },
            trailing: isloading
                ? CupertinoActivityIndicator()
                : Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.black54,
            ),
            title: const Text("版本信息"),
            trailing: FutureBuilder(
              future: _getPackageInfo(),
              builder: (BuildContext context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    {
                      return Text(snapshot.data);
                    }
                  default:
                    {
                      return const CupertinoActivityIndicator();
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
