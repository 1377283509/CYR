import 'package:cyr/models/message/message_model.dart';
import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/providers/message/message_provider.dart';
import 'package:cyr/widgets/message/message_card.dart';
import 'package:cyr/widgets/refresh/custom_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String doctorId = Provider.of<DoctorProvider>(context).user.id;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("我的消息", style: Theme.of(context).textTheme.headline1,),
      ),
      body: Consumer<MessageProvider>(
        builder: (_, provider, __) {
          return CustomRefresh(
              onRefresh: () async {
                await provider.getAllMessage(doctorId);
              },
              child: ListView.builder(
                itemCount: provider.messages.length,
                itemBuilder: (context, index) {
                  MessageModel message = provider.messages[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: MessageCard(message),
                  );
                },
              ));
        },
      ),
    );
  }
}
