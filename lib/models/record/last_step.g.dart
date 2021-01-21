// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastStepModel _$LastStepModelFromJson(Map<String, dynamic> json) {
  return LastStepModel(
      id: json['id'] as String,
      visitRecordId: json['visitRecordId'] as String,
      doctorName: json['doctorName'] as String,
      doctorId: json['doctorId'] as String,
      result: json['result'] as String,
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String));
}

Map<String, dynamic> _$LastStepModelToJson(LastStepModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitRecordId': instance.visitRecordId,
      'doctorName': instance.doctorName,
      'doctorId': instance.doctorId,
      'result': instance.result,
      'endTime': instance.endTime?.toIso8601String()
    };
