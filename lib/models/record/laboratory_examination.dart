// 化验检查
import 'package:json_annotation/json_annotation.dart';

part 'laboratory_examination.g.dart';

@JsonSerializable()
class LaboratoryExamination {
  String id;
  String visitRecord;
  String remarks;
  // 抽血责任医生
  String drawBloodDoctorId;
  String drawBloodDoctorName;
  // 检验责任医生
  String examinationDoctorName;
  String examinationDoctorId;


  // 抽血时间
  DateTime bloodTime;
  // 到达化验室时间
  DateTime arriveLaboratoryTime;
  // 结果回报时间
  DateTime endTime;
  bool state;
  List<String> images;

  LaboratoryExamination(
      {this.id,
      this.visitRecord,
      this.remarks,
      this.examinationDoctorId,
      this.examinationDoctorName,
      this.drawBloodDoctorId,
      this.drawBloodDoctorName,
      this.bloodTime,
      this.arriveLaboratoryTime,
      this.endTime,
      this.state,
      this.images});

  factory LaboratoryExamination.fromJson(Map<String, dynamic> json) =>
      _$LaboratoryExaminationFromJson(json);

  Map<String, dynamic> toJson() => _$LaboratoryExaminationToJson(this);
}
