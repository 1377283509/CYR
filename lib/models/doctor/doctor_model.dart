class Doctor{
  String id;
  String idCard;
  String name;
  int age;
  String gender;
  bool state;
  String job;
  String department;
  String phone;


  Doctor({this.name, this.age, this.gender, this.state, this.job, this.department, this.phone, this.id,this.idCard});

  Doctor.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    idCard = json["idCard"]??"";
    name = json["name"]??"";
    age = json["age"]??0;
    gender = json["gender"]??"";
    job = json["job"]??"";
    department = json["department"]??"";
    phone = json["phone"]??"";
    state = json["state"]??false;
  }
}