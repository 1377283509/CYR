// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ECG.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ECGModel _$ECGModelFromJson(Map<String, dynamic> json) {
  return ECGModel(
      id: json['_id'] as String,
      visitRecordId: json['visitRecordId'] as String,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      doctorName: json['doctorName'] as String,
      doctorId: json['doctorId'] as String,
      remarks: json['remarks'] as String,
      state: json['state'] as bool);
}

Map<String, dynamic> _$ECGModelToJson(ECGModel instance) => <String, dynamic>{
      'id': instance.id,
      'visitRecordId': instance.visitRecordId,
      'startTime': instance.startTime?.toIso8601String(),
      'images': instance.images,
      'endTime': instance.endTime?.toIso8601String(),
      'doctorName': instance.doctorName,
      'doctorId': instance.doctorId,
      'remarks': instance.remarks,
      'state': instance.state
    };
