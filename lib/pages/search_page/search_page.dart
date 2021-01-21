import 'package:cyr/models/model_list.dart';
import 'package:cyr/providers/patient/patient_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:provider/provider.dart';

class SearchPatientsPage extends SearchDelegate<String> {
  // 是否需要返回数据
  final bool needBack;
  SearchPatientsPage({this.needBack = true});

  SearchHistoryUtil _historyUtil = new SearchHistoryUtil();
  @override
  String get searchFieldLabel => "输入姓名开始查询";

  @override
  TextStyle get searchFieldStyle => TextStyle(fontSize: 16.0);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.white,
      primarySwatch: Colors.indigo,
      appBarTheme: const AppBarTheme(
          color: Colors.white, brightness: Brightness.light, elevation: 0),
      primaryIconTheme: IconThemeData(color: Colors.black54),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _historyUtil.add(query);
    return FutureBuilder(
      future: _search(context, query),
      builder: (context, snapshot) {
        bool state = snapshot.connectionState == ConnectionState.done;
        List<IDCard> list = snapshot.data ?? [];
        return state
            ? list.length == 0
                ? Container(
                    child: const Center(
                      child: Text("库中无此患者"),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: list.map((e) => buildCard(context, e)).toList(),
                    ),
                  )
            : Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
      },
    );
  }

  // 结果卡片
  Widget buildCard(BuildContext context, IDCard idCard) {
    return InkWell(
      onTap: () {
        close(context, idCard.toString());
      },
      child: IDCardWidget(idCard),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _historyUtil._history.length == 0
        ? Container()
        : Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 搜索历史标题
                Container(
                  child: const Text(
                    "搜索历史",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                // 历史记录
                Wrap(
                  alignment: WrapAlignment.start,
                  children: _historyUtil.history
                      .map((e) => SearchSuggestionWidget(
                            value: e,
                            onTap: () {
                              query = e;
                            },
                          ))
                      .toList(),
                ),

                const SizedBox(
                  height: 6.0,
                ),
                // 清除历史记录
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomConfirmDialog(title: "确认清除全部搜索记录吗?");
                        }).then((value) {
                      if (value) {
                        _historyUtil.clear();
                      }
                    });
                  },
                  splashColor: Colors.grey[300],
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.delete,
                            size: 16.0,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            "清空搜索历史",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )),
                )
              ],
            ));
  }

  _search(BuildContext context, query) async {
    PatientProvider patientProvider = Provider.of<PatientProvider>(context);
    return await patientProvider.search(query);
  }
}

// 搜索历史 widget
class SearchSuggestionWidget extends StatelessWidget {
  final String value;
  final Function onTap;
  SearchSuggestionWidget({@required this.value, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: ActionChip(
        label: Text(value),
        backgroundColor: Colors.grey[200],
        onPressed: onTap,
      ),
    );
  }
}

// 搜索历史 工具类
class SearchHistoryUtil {
  String _key = "searchHistory";

  SharedPreferences _sharedPreferences;

  List<String> _history = [];
  List<String> get history => _history;

  SearchHistoryUtil() {
    init();
  }

  // 初始化数据
  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _history = _sharedPreferences.getStringList(_key) ?? [];
  }

  // 添加历史记录
  add(String value) {
    if (_history.indexOf(value) == -1 && value != null) {
      _history.add(value);
      _sharedPreferences.setStringList(_key, _history);
    }
  }

  // 清空历史记录
  clear() {
    _history = [];
    _sharedPreferences.setStringList(_key, _history);
  }
}
