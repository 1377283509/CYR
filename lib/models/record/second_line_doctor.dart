
import 'package:json_annotation/json_annotation.dart';

part 'second_line_doctor.g.dart';

@JsonSerializable()
class SecondLineDoctorModel{
  String id;
  String visitRecord;
  // 通知时间
  DateTime notificationTime;
  // 二线医生
  String secondDoctorName;
  String secondDoctorId;

  // 二线医生到达时间
  DateTime arriveTime;
  // 责任医生
  String doctorName;
  String doctorId;

  SecondLineDoctorModel(
  {this.id,
    this.visitRecord,
    this.notificationTime,
    this.secondDoctorName,
    this.secondDoctorId,
    this.arriveTime,
    this.doctorName,
    this.doctorId});

  factory SecondLineDoctorModel.fromJson(Map<String, dynamic> json)=>_$SecondLineDoctorFromJson(json);

  Map<String, dynamic> toJson() => _$SecondLineDoctorToJson(this);
}