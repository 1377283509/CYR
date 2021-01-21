class IDCard {
  String name;
  String gender;
  int age;
  String id;
  String address;
  IDCard({this.id, this.name, this.age, this.gender, this.address});

  IDCard.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    gender = json["gender"] ?? "";
    age = json["age"] ?? "";
    id = json["idCard"] ?? "";
    address = json["address"] ?? "";
  }

  IDCard.fromString(String s) {
    List<String> _list = s.split("/");
    name = _list[0] ?? "";
    age = int.parse(_list[1]) ?? 0;
    gender = _list[2] ?? "";
    id = _list[3] ?? "";
    address = _list[4] ?? "";
  }

  @override
  String toString() {
    return "$name/$age/$gender/$id/$address";
  }
}

class Patient {
  // 就诊记录ID
  String id;
  String name;
  String gender;
  String phone;
  String idCard;
  int age;
  String doctorName;
  String doctorId;
  String wardAddress;
  DateTime visitTime;
  DateTime diseaseTime;
  bool isWeekUpStroke;

  Patient(
      {this.id,
      this.name,
      this.gender,
      this.phone,
      this.idCard,
      this.doctorId,
      this.age,
      this.doctorName,
      this.wardAddress,
      this.visitTime,
      this.isWeekUpStroke,
      this.diseaseTime});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    wardAddress = json["wardAddress"];
    if (json["visitTime"] != null) {
      visitTime = DateTime.parse(json["visitTime"]);
    }
    if (json["diseaseTime"] != null) {
      diseaseTime = DateTime.parse(json["diseaseTime"]);
    }
    isWeekUpStroke = json["isWeekUpStroke"] ?? false;
    doctorId = json["doctorId"];
    doctorName = json["doctorName"];
    Map patient = json["patient"][0];
    idCard = patient["idCard"];
    name = patient["name"];
    gender = patient["gender"];
    phone = patient["phone"];
    age = patient["age"];
  }
}
