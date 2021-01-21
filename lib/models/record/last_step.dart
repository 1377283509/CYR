import 'package:json_annotation/json_annotation.dart';

part 'last_step.g.dart';

@JsonSerializable()
class LastStepModel {
  String id;
  String visitRecordId;
  String doctorName;
  String doctorId;
  String result;
  DateTime endTime;

  LastStepModel(
      {this.id,
      this.visitRecordId,
      this.doctorName,
      this.doctorId,
      this.result,
      this.endTime});
  factory LastStepModel.fromJson(Map<String, dynamic> json)=>_$LastStepModelFromJson(json);

  Map<String, dynamic> toJson() => _$LastStepModelToJson(this);
}
