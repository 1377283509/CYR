// 静脉溶栓
import 'package:json_annotation/json_annotation.dart';

part 'ivct.g.dart';

@JsonSerializable()
class IVCTModel {
  String id;
  String visitRecordId;

  //  知情
  DateTime startWitting;
  DateTime endWitting;
  String wittingUtil;

  // 前NIHSS评分
  String beforeNIHSS;

  // 开始时间
  DateTime startTime;

  // 风险评估
  String riskAssessment;

  // 用药信息
  String medicineInfo;

  // 后NIHSS
  String afterNIHSS;

  // 不良反应
  String adverseReaction;
  String doctorName;
  String doctorId;
  DateTime endTime;

  IVCTModel(
  {this.id,
    this.visitRecordId,
    this.startWitting,
    this.endWitting,
    this.wittingUtil,
    this.beforeNIHSS,
    this.startTime,
    this.riskAssessment,
    this.medicineInfo,
    this.afterNIHSS,
    this.adverseReaction,
    this.doctorName,
    this.doctorId});

  factory IVCTModel.fromJson(Map<String, dynamic> json)=>_$IVCTModelFromJson(json);

  Map<String, dynamic> toJson() => _$IVCTModelToJson(this);

}
