
import 'package:json_annotation/json_annotation.dart';

part 'mRS.g.dart';

@JsonSerializable()
class MRSModel{
  String id;
  String visitRecordId;
  String result;
  DateTime endTime;
  String doctorName;
  String doctorId;
  DateTime startTime;

  MRSModel({this.id, this.visitRecordId, this.result, this.endTime,
    this.doctorName, this.doctorId, this.startTime});
  factory MRSModel.fromJson(Map<String, dynamic> json)=>_$MRSModelFromJson(json);

  Map<String, dynamic> toJson() => _$MRSModelToJson(this);
}