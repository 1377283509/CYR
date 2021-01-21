import 'package:json_annotation/json_annotation.dart';

part 'nihss.g.dart';

@JsonSerializable()
class NIHSSModel{
  String id;
  String visitRecordId;
  String result;
  DateTime endTime;
  String doctorName;
  String doctorId;
  DateTime startTime;

  NIHSSModel({this.id, this.visitRecordId, this.result, this.endTime,
    this.doctorName, this.doctorId, this.startTime});

  factory NIHSSModel.fromJson(Map<String, dynamic> json)=>_$NIHSSModelFromJson(json);

  Map<String, dynamic> toJson() => _$NIHSSModelToJson(this);
}