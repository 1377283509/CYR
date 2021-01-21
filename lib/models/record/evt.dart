import 'package:json_annotation/json_annotation.dart';

part 'evt.g.dart';

@JsonSerializable()
class EVTModel {
  String id;
  String visitRecordId;

  DateTime startWitting;
  DateTime endWitting;
  String wittingUtil;

  String beforeNIHSS;

  // 到达手术室大门时间
  DateTime arriveTime;
  // 上手术台时间
  DateTime startTime;
  // 责任血管评估完成时间
  DateTime assetsTime;

  // 穿刺开始时间
  DateTime punctureTime;

  // 造影完成时间
  DateTime radiographyTime;

  // 仅造影
  bool onlyRadiography;

  // 手术方法
  String methods;

  // 血管再通时间
  DateTime revascularizationTime;

  // 手术结束时间
  DateTime endTime;

  // mTICI分级
  String mTICI;

  // 治疗结果
  String result;

  // 后NIHSS
  String afterNIHSS;

  // 不良事件
  String adverseReaction;

  String doctorName;
  String doctorId;

  EVTModel(
  { this.id,
    this.visitRecordId,
    this.startWitting,
    this.endWitting,
    this.wittingUtil,
    this.beforeNIHSS,
    this.arriveTime,
    this.startTime,
    this.assetsTime,
    this.punctureTime,
    this.radiographyTime,
    this.onlyRadiography,
    this.methods,
    this.revascularizationTime,
    this.endTime,
    this.mTICI,
    this.result,
    this.afterNIHSS,
    this.adverseReaction,
    this.doctorName,
    this.doctorId});

  factory EVTModel.fromJson(Map<String, dynamic> json)=>_$RVTModelFromJson(json);

  Map<String, dynamic> toJson() => _$RVTModelToJson(this);
}
