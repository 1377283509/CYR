import 'dart:async';

import 'package:cyr/pages/patients_page/finished_patients_list.dart';
import 'package:cyr/providers/message/message_provider.dart';
import 'package:cyr/providers/patient/patient_provider.dart';
import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:provider/provider.dart';
import 'package:cyr/pages/page_list.dart';
import 'package:cyr/utils/navigator/custom_navigator.dart';
import 'package:cyr/widgets/message/message_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("卒中中心信息采集"),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: Hero(
              tag: "user-header",
              child: const Icon(
                Icons.account_circle,
                size: 30,
              ),
            ),
            onPressed: () {
              // navigateTo(context, UserPage());
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          QrScanButton(),
        ],
      ),
      drawer: UserPage(),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // user state
            StateCard(),
            BlankSpace(),
            // 添加患者
            InkWell(
              onTap: () {
                navigateTo(context, AddPatientPage());
              },
              child: const Cell(
                title: "添加患者",
                icon: Icons.add,
                color: Colors.blue,
              ),
            ),
            BlankSpace(),
            NewPatients(),
            BlankSpace(),
            // 完成就诊的患者
            InkWell(
              onTap: () {
                navigateTo(context, FinishedPatientsPage());
              },
              child: const Cell(
                title: "结束患者",
                icon: Icons.restore,
                color: Colors.red,
              ),
            ),
            BlankSpace(),
            // 消息
            _buildMessageCard(context),
            BlankSpace(),
          ],
        ),
      ),
    );
  }

  // 消息卡片
  _buildMessageCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text(
              "新消息",
              style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.grey,
                        size: 18,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      const Text(
                        "清除",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    await Provider.of<MessageProvider>(context, listen: false)
                        .setAllRead(context);
                  },
                ),
                TextButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.history,
                        color: Colors.grey,
                        size: 18,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      const Text(
                        "历史",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  onPressed: () {
                    navigateTo(context, MessagePage());
                  },
                ),
              ],
            ),
          ),
          MessageList()
        ],
      ),
    );
  }
}

class NewPatients extends StatefulWidget {
  @override
  _NewPatientsState createState() => _NewPatientsState();
}

class _NewPatientsState extends State<NewPatients> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
      await Provider.of<PatientProvider>(context, listen: false)
          .getPatientsCount();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, PatientsPage());
      },
      child: Cell(
        title: "新到患者",
        icon: Icons.menu,
        color: Colors.green,
        trailling: FutureBuilder(
          future: Provider.of<PatientProvider>(context, listen: false)
          .getPatientsCount(),
          builder: (context, snapshot) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Consumer<PatientProvider>(
                builder: (context, provider, child) {
                  if(provider.patientCount != null){
                    return Text("${provider.patientCount}", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),);
                  }else{
                    return CupertinoActivityIndicator();
                  }
                },
              ),
            );
          }
        ),
      ),
    );
  }
}
