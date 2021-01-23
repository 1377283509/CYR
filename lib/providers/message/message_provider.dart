import 'package:cyr/models/message/message_model.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class MessageProvider with ChangeNotifier {
  CloudBaseUtil _cloudBase;
  MessageProvider() {
    _cloudBase = CloudBaseUtil();
  }

  List<MessageModel> _messages = [];
  List<MessageModel> get messages =>_messages;

  // 设置已读
  Future<void> setRead(String messageId) async {
    try {
      await _cloudBase
          .callFunction("message", {"\$url": "setRead", "id": messageId});
    } catch (e) {
      print(e);
    }
  }

  // 获取所有消息
  Future<void> getAllMessage(String doctorId) async {
    _messages = [];
    try{
      CloudBaseResponse res = await _cloudBase.callFunction("message", {
        "\$url": "getAll",
        "doctor": doctorId
      });
      List list = res.data["data"];
      list.forEach((element) {
        _messages.add(MessageModel.fromJson(element));
      });
    }catch(e){
      print(e);
    }
  }
}
