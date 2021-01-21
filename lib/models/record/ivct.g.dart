// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ivct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IVCTModel _$IVCTModelFromJson(Map<String, dynamic> json) {
  return IVCTModel(
      id: json['_id'] as String,
      visitRecordId: json['visitRecordId'] as String,
      startWitting: json['startWitting'] == null
          ? null
          : DateTime.parse(json['startWitting'] as String),
      endWitting: json['endWitting'] == null
          ? null
          : DateTime.parse(json['endWitting'] as String),
      wittingUtil: json['wittingUtil'] as String,
      beforeNIHSS: json['beforeNIHSS'] as String,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      riskAssessment: json['riskAssessment'] as String,
      medicineInfo: json['medicineInfo'] as String,
      afterNIHSS: json['afterNIHSS'] as String,
      adverseReaction: json['adverseReaction'] as String,
      doctorName: json['doctorName'] as String,
      doctorId: json['doctorId'] as String)
    ..endTime = json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String);
}

Map<String, dynamic> _$IVCTModelToJson(IVCTModel instance) => <String, dynamic>{
      'id': instance.id,
      'visitRecordId': instance.visitRecordId,
      'startWitting': instance.startWitting?.toIso8601String(),
      'endWitting': instance.endWitting?.toIso8601String(),
      'wittingUtil': instance.wittingUtil,
      'beforeNIHSS': instance.beforeNIHSS,
      'startTime': instance.startTime?.toIso8601String(),
      'riskAssessment': instance.riskAssessment,
      'medicineInfo': instance.medicineInfo,
      'afterNIHSS': instance.afterNIHSS,
      'adverseReaction': instance.adverseReaction,
      'doctorName': instance.doctorName,
      'doctorId': instance.doctorId,
      'endTime': instance.endTime?.toIso8601String()
    };
