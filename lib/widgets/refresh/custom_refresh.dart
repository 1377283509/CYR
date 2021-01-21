import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefresh extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  final Function onRefresh;
  final Function onLoad;
  final Widget child;

  CustomRefresh({@required this.onRefresh, @required this.child, this.onLoad});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: _refreshController,
        physics: ClampingScrollPhysics(),
        onRefresh: () async {
           await onRefresh();
           _refreshController.refreshCompleted();
        },
        onLoading: () async {
          if(onLoad!=null){
            await onLoad();
          }
        },
        child: child);
  }
}
