// 生命体征

import 'package:json_annotation/json_annotation.dart';

part 'vitals_signs.g.dart';

@JsonSerializable()
class VitalSignsModel {
  DateTime startTime;
  String id;
  String visitRecordId;
  // 血糖
  String bloodSugar;
  // 血压
  String bloodPressure;
  // 体重
  String weight;

  // 责任医生
  String doctorId;
  String doctorName;

  DateTime endTime;
  bool state;

  VitalSignsModel(
      {this.id,
      this.visitRecordId,
      this.bloodSugar,
      this.bloodPressure,
      this.weight,
      this.doctorId,
      this.doctorName,
      this.endTime,
        this.startTime,
      this.state});
  factory VitalSignsModel.fromJson(Map<String, dynamic> json)=>_$VitalSignsFromJson(json);

  Map<String, dynamic> toJson() => _$VitalSignsToJson(this);
}
