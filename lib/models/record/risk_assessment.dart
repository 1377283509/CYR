
class RiskAssessmentModel{
  String id;
  // 出现时长
  String appearTime;
  // 有缺血性卒中导致的神经功能缺损症状
  bool hasSONI;
  // 年龄大于等于18岁
  bool hasAdult;
  // 签署知情同意书
  bool hasEndWitting;
  // 近3个月有严重颅外伤或卒中史
  bool hasStrokeHistory;
  // 颅内出血
  bool intracranialHemorrhage; 
  // 近一周内有在不易压迫部位的动脉穿刺
  bool hasArteriopuncture;
  // 既往颅内出血
  bool hasIntracranialHemorrhageHistory;
  // 颅内肿瘤
  bool hasIntracranialTumors;
  // 近期有颅内或锥管内手术史
  bool hasOperationHistory;
  // 血压升高
  bool hasHypertension;
  // 活动性内脏出血
  bool hasActiveVisceralBleeding;
  // 急性出血倾向
  bool hasAcuteBleedingTendency;
  // 低分子肝素治疗
  bool hasLMWH;
  // INR值高或PT长
  bool hasHigherINPorPT;
  // 实验室检查异常
  bool abnormalLaboratory;
  // 血糖异常
  bool pathoglycemia;
  //  大面积梗死
  bool hasMassiveInfarction;
  // 主动脉弓夹层
  bool isDissectedArch;




  // 轻型卒中
  bool isLightStroke;
  // 妊娠
  bool hasGravidity; 
  // 癫痫发作后出现的神经功能损害症状
  bool hasSymptomsOfEpilepsy;
  // 大型外科手术或严重外伤
  bool hasSevereTrauma;
  // 肠胃或泌尿系统出血
  bool hasUrinaryBleeding;
  // 颅外段颈动脉夹层
  bool hasECAD;
  // 痴呆
  bool isDementia;
  // 既往疾病遗留较严重的神经功能残疾
  bool hasNeurologicalDisability; 
  // 动脉畸形
  bool hasArteryMalformation;
  // 颅内微出血
  bool hasIntracranialHemorrhage;
  // 使用违禁药物
  bool hasUsedIllegalDrugs;
  // 类卒中
  bool isParapoplexy;
  // 严重卒中
  bool isSevereStroke;
  // 口服抗凝药
  bool hasOralAnticoagulants;

  RiskAssessmentModel({
      this.id,
      this.appearTime,
      this.hasSONI,
      this.hasAdult,
      this.hasEndWitting,
      this.hasStrokeHistory,
      this.intracranialHemorrhage,
      this.hasArteriopuncture,
      this.hasIntracranialHemorrhageHistory,
      this.hasIntracranialTumors,
      this.hasOperationHistory,
      this.hasHypertension,
      this.hasActiveVisceralBleeding,
      this.hasAcuteBleedingTendency,
      this.hasLMWH,
      this.hasHigherINPorPT,
      this.abnormalLaboratory,
      this.pathoglycemia,
      this.hasMassiveInfarction,
      this.isDissectedArch,
      this.isLightStroke,
      this.hasGravidity,
      this.hasSymptomsOfEpilepsy,
      this.hasSevereTrauma,
      this.hasUrinaryBleeding,
      this.hasECAD,
      this.isDementia,
      this.hasNeurologicalDisability,
      this.hasArteryMalformation,
      this.hasIntracranialHemorrhage,
      this.hasUsedIllegalDrugs,
      this.isParapoplexy,
      this.isSevereStroke,
      this.hasOralAnticoagulants});

  factory RiskAssessmentModel.fromJson(Map<String, dynamic> json){
    return RiskAssessmentModel(
      id: json["_id"] as String,
      appearTime: json["appearTime"] as String,
      hasSONI: json["hasSONI"] as bool??false,
      hasAdult: json["hasAdult"] as bool??false,
      hasEndWitting: json["hasEndWitting"] as bool??false,
      hasStrokeHistory: json["hasStrokeHistory"] as bool??false,
      intracranialHemorrhage: json["intracranialHemorrhage"] as bool??false,
      hasArteriopuncture: json["hasArteriopuncture"] as bool??false,
      hasIntracranialHemorrhageHistory: json["hasIntracranialHemorrhageHistory"] as bool??false,
      hasIntracranialTumors: json["hasIntracranialTumors"] as bool??false,
      hasOperationHistory: json["hasOperationHistory"] as bool??false,
      hasHypertension: json["hasHypertension"] as bool??false,
      hasActiveVisceralBleeding: json["hasActiveVisceralBleeding"] as bool??false,
      hasAcuteBleedingTendency: json["hasAcuteBleedingTendency"] as bool??false,
      hasLMWH: json["hasLMWH"] as bool??false,
      hasHigherINPorPT: json["hasHigherINPorPT"] as bool??false,
      abnormalLaboratory: json["abnormalLaboratory"] as bool??false,
      pathoglycemia: json["pathoglycemia"] as bool??false,
      hasMassiveInfarction: json["hasMassiveInfarction"] as bool??false,
      isDissectedArch: json["isDissectedArch"] as bool??false,
      isLightStroke: json["isLightStroke"] as bool??false,
      hasGravidity: json["hasGravidity"] as bool??false,
      hasSymptomsOfEpilepsy: json["hasSymptomsOfEpilepsy"] as bool??false,
      hasSevereTrauma: json["hasSevereTrauma"] as bool??false,
      hasUrinaryBleeding: json["hasUrinaryBleeding"] as bool??false,
      hasECAD: json["hasECAD"] as bool??false,
      isDementia: json["isDementia"] as bool??false,
      hasNeurologicalDisability: json["hasNeurologicalDisability"] as bool??false,
      hasArteryMalformation: json["hasArteryMalformation"] as bool??false,
      hasIntracranialHemorrhage: json["hasIntracranialHemorrhage"] as bool??false,
      hasUsedIllegalDrugs: json["hasUsedIllegalDrugs"] as bool??false,
      isParapoplexy: json["isParapoplexy"] as bool??false,
      isSevereStroke: json["isSevereStroke"] as bool??false,
      hasOralAnticoagulants: json["hasOralAnticoagulants"] as bool??false,
    );
  }
  Map<String, dynamic> toJson(){
    return {
      "appearTime": this.appearTime,
    "hasSONI":this.hasSONI,
      "hasAdult":this.hasAdult,
      "hasEndWitting":this.hasEndWitting,
      "hasStrokeHistory":this.hasStrokeHistory,
      "intracranialHemorrhage":this.intracranialHemorrhage,
      "hasArteriopuncture":this.hasArteriopuncture,
      "hasIntracranialHemorrhageHistory":this.hasIntracranialHemorrhageHistory,
      "hasIntracranialTumors":this.hasIntracranialTumors,
      "hasOperationHistory":this.hasOperationHistory,
      "hasHypertension":this.hasHypertension,
      "hasActiveVisceralBleeding":this.hasActiveVisceralBleeding,
      "hasAcuteBleedingTendency":this.hasAcuteBleedingTendency,
      "hasLMWH":this.hasLMWH,
      "hasHigherINPorPT":this.hasHigherINPorPT,
      "abnormalLaboratory":this.abnormalLaboratory,
      "pathoglycemia":this.pathoglycemia,
      "hasMassiveInfarction":this.hasMassiveInfarction,
      "isDissectedArch":this.isDissectedArch,
      "isLightStroke":this.isLightStroke,
      "hasGravidity":this.hasGravidity,
      "hasSymptomsOfEpilepsy":this.hasSymptomsOfEpilepsy,
      "hasSevereTrauma":this.hasSevereTrauma,
      "hasUrinaryBleeding":this.hasUrinaryBleeding,
      "hasECAD":this.hasECAD,
      "isDementia":this.isDementia,
      "hasNeurologicalDisability":this.hasNeurologicalDisability,
      "hasArteryMalformation":this.hasArteryMalformation,
      "hasIntracranialHemorrhage":this.hasIntracranialHemorrhage,
      "hasUsedIllegalDrugs":this.hasUsedIllegalDrugs,
      "isParapoplexy":this.isParapoplexy,
      "isSevereStroke":this.isSevereStroke,
      "hasOralAnticoagulants":this.hasOralAnticoagulants
    };
  }
}

