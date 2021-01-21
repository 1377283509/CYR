// 就诊记录

class VisitRecordModel {
  // 就诊记录ID
  String id;
  // 病人信息
  String patientId;
  String patientName;
  int patientAge;
  String patientGender;
  String bangle;
  // 发病时间
  DateTime diseaseTime;
  // 是否醒后卒中
  bool isWeekUpStroke;
  // 既往史
  String pastHistory;
  // 主诉
  String chiefComplaint;
  // 就诊时间
  DateTime visitTime;
  // 诊断结果
  String result;
  bool isIVCT;
  bool isEVT;
  String lastStep;

  // 是否TIA
  bool isTIA;
  String doctorId;
  String doctorName;
  VisitRecordModel(
      {this.id,
      this.patientId,
      this.diseaseTime,
      this.isWeekUpStroke,
      this.pastHistory,
      this.chiefComplaint,
      this.visitTime,
        this.lastStep,
        this.isEVT,
        this.isIVCT,
      this.patientAge,
      this.patientGender,
      this.patientName,
      this.result,
        this.isTIA,
      this.bangle,
      this.doctorName,
      this.doctorId});

  VisitRecordModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    bangle = json["bangle"];
    if (json["diseaseTime"] != null) {
      diseaseTime = DateTime.parse(json["diseaseTime"]);
    }
    if (json["visitTime"] != null) {
      visitTime = DateTime.parse(json["visitTime"]);
    }
    result = json["result"];
    isTIA = json["isTIA"];
    lastStep = json["lastStep"];
    isWeekUpStroke = json["isWeekUpStroke"] ?? false;
    isIVCT = json["isIVCT"] as bool??false;
    isEVT = json["isEVT"] as bool??false;
    pastHistory = json["pastHistory"];
    chiefComplaint = json["chiefComplaint"];
    doctorId = json["doctorId"];
    doctorName = json["doctorName"];
    if (json["patient"] != null && json["patient"].isNotEmpty) {
      patientId = json["patient"][0]["idCard"];
      patientAge = json["patient"][0]["age"];
      patientGender = json["patient"][0]["gender"];
      patientName = json["patient"][0]["name"];
    }
  }
}

// 记录类型
enum RecordType {
  // EXAMINE 开头为检查记录
  EXAMINE_ECG,
  EXAMINE_CT,
  EXAMINE_CTA,
  EXAMINE_NORMAL_BLOOD,
  EXAMINE_COAGULATION_BLOOD,
  EXAMINE_BIOCHEMISTRY,
  EXAMINE_LIVER,
  EXAMINE_RENAL,
  EXAMINE_BLOOD_PRESSURE,
  EXAMINE_BLOOD_SUGAR,
  // ASSESS 开头为评估记录
  ASSESS_ASPECTS,
  ASSESS_NIHSS,
  ASSESS_MRS,
  ASSESS_AWARENESS,
  // CURE 开头为治疗记录
  CURE_IVCT,
  CURE_EVT,

  // 去向
  NEXT_STEP,

  // 病房
  BIND_WARD_ADDRESS,
  // 主治医生
  BIND_DOCTOR,
  // 手环
  BIND_BANGLE,
  // 添加就诊时间
  ADD_VISIT_RECORD,
}

// 记录名
Map<RecordType, String> recordNames = {
  RecordType.EXAMINE_BLOOD_PRESSURE: "血压",
  RecordType.EXAMINE_BLOOD_SUGAR: "血糖",
  RecordType.EXAMINE_ECG: "心电图",
  RecordType.EXAMINE_CT: "CT",
  RecordType.EXAMINE_NORMAL_BLOOD: "血液常规报告",
  RecordType.EXAMINE_COAGULATION_BLOOD: "凝血报告",
  RecordType.EXAMINE_BIOCHEMISTRY: "生化报告",
  RecordType.EXAMINE_LIVER: "肝功能报告",
  RecordType.EXAMINE_RENAL: "肾功能及电解质报告",
  RecordType.EXAMINE_CTA: "CT血管造影",
  RecordType.ASSESS_ASPECTS: "ASPECTS评分",
  RecordType.ASSESS_AWARENESS: "患者意识",
  RecordType.ASSESS_MRS: "MRS评分",
  RecordType.ASSESS_NIHSS: "NIHSS评分",
  RecordType.CURE_EVT: "血管内治疗",
  RecordType.CURE_IVCT: "静脉溶栓",
  RecordType.NEXT_STEP: "去向",
  RecordType.BIND_BANGLE: "绑定手环",
  RecordType.BIND_DOCTOR: "主治医生",
  RecordType.BIND_WARD_ADDRESS: "病房信息",
  RecordType.ADD_VISIT_RECORD: "就诊时间"
};
