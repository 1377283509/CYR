import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/doctor_page/widgets/doctor_card.dart';
import 'package:cyr/pages/page_list.dart';
import 'package:cyr/pages/stat_page/flow_stat_page.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          "个人中心",
        ),
      ),
      body: UserPageBody(),
    );
  }
}

class UserPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Doctor doctor = Provider.of<DoctorProvider>(context).user;
    return SingleChildScrollView(
      child: Column(
        children: [
          DoctorCard(doctor),
          const BlankSpace(),
          _buildStatCard(context),
          const BlankSpace(),
          AppInfoCard()
        ],
      ),
    );
  }

  // 统计
  Widget _buildStatCard(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NavigateTile(
              icon: Icon(
                Icons.timeline,
                color: Colors.orange,
              ),
              title: "患者数据统计",
              page: PatientStatPage(),
            ),
            NavigateTile(
              icon: Icon(
                Icons.bar_chart,
                color: Colors.green,
              ),
              title: "流程耗时分析",
              page: FlowStatPage(),
            ),
          ],
        ));
  }
}
