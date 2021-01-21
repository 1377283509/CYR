class MessageModel{
  String id;
  DateTime sendTime;
  bool state;
  String content;
  String visitRecord;
  String patientName;

  MessageModel.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    sendTime = DateTime.parse(json["sendTime"]);
    state = json["state"];
    content = json["content"];
    visitRecord = json["visitRecord"];
    patientName = json["patientName"];
  }
}