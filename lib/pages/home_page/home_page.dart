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
        title:const Text("卒中中心信息采集"),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon:Hero(
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
              child:const Cell(
                title: "添加患者",
                icon: Icons.add,
                color: Colors.blue,
              ),
            ),
            BlankSpace(),
            InkWell(
              onTap: () {
                navigateTo(context, PatientsPage());
              },
              child:const Cell(
                title: "所有患者",
                icon: Icons.menu,
                color: Colors.green,
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
      margin:const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title:const Text(
              "新消息",
              style:
              const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            trailing:InkWell(
                onTap: (){
                  navigateTo(context, MessagePage());
                },
                child: const  Icon(Icons.history)),
          ),
          MessageList()
        ],
      ),
    );
  }
}


