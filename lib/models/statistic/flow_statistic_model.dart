
// 流程记录
enum FlowRecord {
  CT,
  ECG,
  LaboratoryExamination,
  SecondLine,
  VitalSigns,
  NIHSS,
  MRS,
  IVCT,
  EVT
}

Map<FlowRecord,String> flowNames = {
  FlowRecord.CT: "CT",
  FlowRecord.ECG: "心电图",
  FlowRecord.LaboratoryExamination: "化验检查",
  FlowRecord.SecondLine: "二线医生",
  FlowRecord.VitalSigns: "生命体征",
  FlowRecord.NIHSS: "NIHSS评分",
  FlowRecord.MRS: "mRS评分",
  FlowRecord.IVCT: "静脉溶栓",
  FlowRecord.EVT: "血管内治疗",
};

class RecordStatisticModel {
  String id;
  FlowRecord flowRecord;
  int year;
  int month;
  int totalCount;
  int overTimeCount;
  int averageTime;

  String get title => flowNames[flowRecord];

  RecordStatisticModel(
      {this.id,
      this.year,
      this.month,
      this.totalCount,
      this.overTimeCount,
      this.averageTime, this.flowRecord});

  factory RecordStatisticModel.fromJson(Map<String, dynamic> json, FlowRecord flowRecord) {
    return RecordStatisticModel(
        id: json["_id"] as String,
      flowRecord: flowRecord,
        year: json["year"] as int,
        month: json["month"] as int,
        totalCount: json["totalCount"] as int,
        overTimeCount: json["overTimeCount"] as int,
        averageTime: json["averageTime"] as int,);
  }
}
