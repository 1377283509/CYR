import 'package:cyr/providers/statistic/flow_statistic_provider.dart';
import 'package:cyr/widgets/title/sub_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/flow_statistic_card.dart';

// 流程统计页
class FlowStatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("流程耗时分析"),
        ),
        body: ChangeNotifierProvider(
          create: (BuildContext context) => FlowStatisticProvider(),
          child: FlowStatePageBody(),
        ));
  }
}

class FlowStatePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<FlowStatisticProvider>(context).initData(context),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 流程信息
                SizedBox(
                  height: 12,
                ),
                SubTitle(
                  title: "流程时长统计",
                  showMore: false,
                ),
                FlowStatisticCard(),
                SizedBox(
                  height: 12,
                ),
                SubTitle(
                  title: "流程时长数据",
                  showMore: false,
                ),
                FlowStatisticTable(),
                Container(
                  padding:
                      const EdgeInsets.fromLTRB(12,8,12,24),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "提示：\n      1.表格可以左右滑动，横屏查看效果更好。\n      2.点击流程名可以查看其对应详情。",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                )
              ],
            ),
          );
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
