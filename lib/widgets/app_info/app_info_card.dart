import 'package:cyr/pages/feed_back/feed_back.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/navigator/custom_navigator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppInfoCard extends StatefulWidget {
  @override
  _AppInfoCardState createState() => _AppInfoCardState();
}

class _AppInfoCardState extends State<AppInfoCard> {
  String _newVersion;
  // 获取版本信息
  Future<String> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  // 检查更新
  void _checkUpdate() {
    setState(() {
      _newVersion = "已是最新版";
    });
  }


  @override
  void initState() {
    super.initState();
    _checkUpdate();
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
            trailing: Text(_newVersion),
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
