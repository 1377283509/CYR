

import 'package:json_annotation/json_annotation.dart';

part 'ECG.g.dart';

@JsonSerializable()
class ECGModel {
  String id;
  String visitRecordId;

  // 开始时间
  DateTime startTime;
  List<String> images;
  // 结束时间
  DateTime endTime;
  String doctorName;
  String doctorId;
  String remarks;
  bool state;

  ECGModel({this.id, this.visitRecordId, this.startTime, this.images,
    this.endTime, this.doctorName, this.doctorId, this.remarks, this.state});

  factory ECGModel.fromJson(Map<String, dynamic> json)=>_$ECGModelFromJson(json);

  Map<String, dynamic> toJson() => _$ECGModelToJson(this);
}
