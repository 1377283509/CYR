// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CT.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CTModel _$CTModelFromJson(Map<String, dynamic> json) {
  return CTModel(
      orderTime: json['orderTime'] == null
          ? null
          : DateTime.parse(json['orderTime'] as String),
      visitRecordId: json['visitRecordId'] as String,
      id: json['_id'] as String,
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      doctorName: json['doctorName'] as String,
      orderDoctorName: json['orderDoctorName'] as String,
      orderDoctorId: json['orderDoctorId'] as String,
      doctorId: json['doctorId'] as String,
      remarks: json['remarks'] as String,
      state: json['state'] as bool,
      arriveTime: json['arriveTime'] == null
          ? null
          : DateTime.parse(json['arriveTime'] as String));
}

Map<String, dynamic> _$CTModelToJson(CTModel instance) => <String, dynamic>{
      'orderTime': instance.orderTime?.toIso8601String(),
      'visitRecordId': instance.visitRecordId,
      'id': instance.id,
      'images': instance.images,
      'endTime': instance.endTime?.toIso8601String(),
      'doctorName': instance.doctorName,
      'doctorId': instance.doctorId,
      'remarks': instance.remarks,
      'state': instance.state,
      'arriveTime': instance.arriveTime?.toIso8601String(),
      "orderDoctorId": instance.orderDoctorId,
      "orderDoctorName": instance.orderDoctorName,
    };
