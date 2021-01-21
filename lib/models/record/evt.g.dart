// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EVTModel _$RVTModelFromJson(Map<String, dynamic> json) {
  return EVTModel(
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
      arriveTime: json['arriveTime'] == null
          ? null
          : DateTime.parse(json['arriveTime'] as String),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      assetsTime: json['assetsTime'] == null
          ? null
          : DateTime.parse(json['assetsTime'] as String),
      punctureTime: json['punctureTime'] == null
          ? null
          : DateTime.parse(json['punctureTime'] as String),
      radiographyTime: json['radiographyTime'] == null
          ? null
          : DateTime.parse(json['radiographyTime'] as String),
      onlyRadiography: json['onlyRadiography'] as bool,
      methods: json['methods'] as String,
      revascularizationTime: json['revascularizationTime'] == null
          ? null
          : DateTime.parse(json['revascularizationTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      mTICI: json['mTICI'] as String,
      result: json['result'] as String,
      afterNIHSS: json['afterNIHSS'] as String,
      adverseReaction: json['adverseReaction'] as String,
      doctorName: json['doctorName'] as String,
      doctorId: json['doctorId'] as String);
}

Map<String, dynamic> _$RVTModelToJson(EVTModel instance) => <String, dynamic>{
      'id': instance.id,
      'visitRecordId': instance.visitRecordId,
      'startWitting': instance.startWitting?.toIso8601String(),
      'endWitting': instance.endWitting?.toIso8601String(),
      'wittingUtil': instance.wittingUtil,
      'beforeNIHSS': instance.beforeNIHSS,
      'arriveTime': instance.arriveTime?.toIso8601String(),
      'startTime': instance.startTime?.toIso8601String(),
      'assetsTime': instance.assetsTime?.toIso8601String(),
      'punctureTime': instance.punctureTime?.toIso8601String(),
      'radiographyTime': instance.radiographyTime?.toIso8601String(),
      'onlyRadiography': instance.onlyRadiography,
      'methods': instance.methods,
      'revascularizationTime':
          instance.revascularizationTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'mTICI': instance.mTICI,
      'result': instance.result,
      'afterNIHSS': instance.afterNIHSS,
      'adverseReaction': instance.adverseReaction,
      'doctorName': instance.doctorName,
      'doctorId': instance.doctorId
    };
