// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second_line_doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecondLineDoctorModel _$SecondLineDoctorFromJson(Map<String, dynamic> json) {
  return SecondLineDoctorModel(
      id: json['_id'] as String,
      visitRecord: json['visitRecord'] as String,
      notificationTime: json['notificationTime'] == null
          ? null
          : DateTime.parse(json['notificationTime'] as String),
      secondDoctorName: json['secondDoctorName'] as String,
      secondDoctorId: json['secondDoctorId'] as String,
      arriveTime: json['arriveTime'] == null
          ? null
          : DateTime.parse(json['arriveTime'] as String),
      doctorName: json['doctorName'] as String,
      doctorId: json['doctorId'] as String);
}

Map<String, dynamic> _$SecondLineDoctorToJson(SecondLineDoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitRecord': instance.visitRecord,
      'notificationTime': instance.notificationTime?.toIso8601String(),
      'secondDoctorName': instance.secondDoctorName,
      'secondDoctorId': instance.secondDoctorId,
      'arriveTime': instance.arriveTime?.toIso8601String(),
      'doctorName': instance.doctorName,
      'doctorId': instance.doctorId
    };
