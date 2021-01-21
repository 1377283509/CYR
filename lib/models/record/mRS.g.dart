// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mRS.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MRSModel _$MRSModelFromJson(Map<String, dynamic> json) {
  return MRSModel(
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

Map<String, dynamic> _$MRSModelToJson(MRSModel instance) => <String, dynamic>{
      'id': instance.id,
      'visitRecordId': instance.visitRecordId,
      'result': instance.result,
      'endTime': instance.endTime?.toIso8601String(),
      'doctorName': instance.doctorName,
      'doctorId': instance.doctorId,
      'startTime': instance.startTime?.toIso8601String()
    };
