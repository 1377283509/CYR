// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vitals_signs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VitalSignsModel _$VitalSignsFromJson(Map<String, dynamic> json) {
  return VitalSignsModel(
      id: json['_id'] as String,
      visitRecordId: json['visitRecordId'] as String,
      bloodSugar: json['bloodSugar'] as String,
      bloodPressure: json['bloodPressure'] as String,
      weight: json['weight'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      state: json['state'] as bool);
}

Map<String, dynamic> _$VitalSignsToJson(VitalSignsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitRecordId': instance.visitRecordId,
      'bloodSugar': instance.bloodSugar,
      'bloodPressure': instance.bloodPressure,
      'weight': instance.weight,
      'doctorId': instance.doctorId,
      'doctorName': instance.doctorName,
      'endTime': instance.endTime?.toIso8601String(),
      'startTime': instance.endTime?.toIso8601String(),
      'state': instance.state
    };
