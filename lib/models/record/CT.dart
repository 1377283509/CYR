import 'package:json_annotation/json_annotation.dart';

part 'CT.g.dart';

@JsonSerializable()
class CTModel {
  String id;
  String visitRecordId;
  // 开单时间
  DateTime orderTime;
  List<String> images;
  // 结果回报时间
  DateTime endTime;
  String doctorName;
  String doctorId;
  String remarks;
  bool state;
  // 到达CT室时间
  DateTime arriveTime;
  // 开单责任医生
  String orderDoctorName;
  String orderDoctorId;

  CTModel(
      {this.orderTime,
      this.visitRecordId,
      this.id,
      this.images,
      this.endTime,
      this.doctorName,
      this.doctorId,
      this.orderDoctorId,
      this.orderDoctorName,
      this.remarks,
      this.state,
      this.arriveTime});

  factory CTModel.fromJson(Map<String, dynamic> json) =>
      _$CTModelFromJson(json);

  Map<String, dynamic> toJson() => _$CTModelToJson(this);
}
