// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nihss.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NIHSSModel _$NIHSSModelFromJson(Map<String, dynamic> json) {
  return NIHSSModel(
      id: json['_id'] as String,
      visitRecordId: json['visitRecordId'] as String,
      result: json['result'] as String,
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      doctorName: json['doctorName'] as String,
      doctorId: json['doctorId'] as String,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String));
}

Map<String, dynamic> _$NIHSSModelToJson(NIHSSModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitRecordId': instance.visitRecordId,
      'result': instance.result,
      'endTime': instance.endTime?.toIso8601String(),
      'doctorName': instance.doctorName,
      'doctorId': instance.doctorId,
      'startTime': instance.startTime?.toIso8601String()
    };
