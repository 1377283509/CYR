// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratory_examination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaboratoryExamination _$LaboratoryExaminationFromJson(
    Map<String, dynamic> json) {
  return LaboratoryExamination(
      id: json['_id'] as String,
      visitRecord: json['visitRecord'] as String,
      remarks: json['remarks'] as String,
      drawBloodDoctorId: json['drawBloodDoctorId'] as String,
      drawBloodDoctorName: json['drawBloodDoctorName'] as String,
      examinationDoctorId: json['examinationDoctorId'] as String,
      examinationDoctorName: json['examinationDoctorName'] as String,
      bloodTime: json['bloodTime'] == null
          ? null
          : DateTime.parse(json['bloodTime'] as String),
      arriveLaboratoryTime: json['arriveLaboratoryTime'] == null
          ? null
          : DateTime.parse(json['arriveLaboratoryTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      state: json['state'] as bool,
      images: (json['images'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$LaboratoryExaminationToJson(
        LaboratoryExamination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitRecord': instance.visitRecord,
      'remarks': instance.remarks,
      'examinationDoctorName': instance.examinationDoctorName,
      'examinationDoctorId': instance.examinationDoctorId,
      'drawBloodDoctorId': instance.drawBloodDoctorId,
      'drawBloodDoctorName': instance.drawBloodDoctorName,
      'bloodTime': instance.bloodTime?.toIso8601String(),
      'arriveLaboratoryTime': instance.arriveLaboratoryTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'state': instance.state,
      'images': instance.images
    };
