import 'package:cyr/models/message/message_model.dart';
import 'package:cyr/pages/page_list.dart';
import 'package:cyr/providers/message/message_provider.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/material.dart';
import '../widget_list.dart';
import 'package:provider/provider.dart';

class MessageCard extends StatelessWidget {
  final MessageModel message;
  MessageCard(this.message);
  @override
  Widget build(BuildContext context) {
    MessageProvider messageProvider = Provider.of<MessageProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          dense: true,
          onTap: () {
            navigateTo(
                context,
                PatientDetailPage(
                  id: message.visitRecord,
                ));
            messageProvider.setRead(message.id);
          },
          leading: const Icon(Icons.local_hotel),
          title: Text(
            message.content,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          subtitle: Text(
              "${message.patientName}  ${formatTime(message.sendTime, format: TimeFormatType.MONTH_DAY_HOUR_MINUTE)}"),
          trailing: Visibility(
            visible: !message.state,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ),
        const CustomDivider()
      ],
    );
  }
}
