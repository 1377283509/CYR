class TimePointModel {
  // 到院时间
  DateTime arriveTime;
  // 就诊时间
  DateTime visitTime;
  // CT完成时间
  DateTime ctFinishedTime;
  // 发病时间
  DateTime diseaseTime;
  // 血管内治疗知情开始时间、签署时间
  DateTime evtStartWittingTime;
  DateTime evtEndWittingTime;
  // 穿刺时间
  DateTime punctureTime;
  // 再通时间
  DateTime revascularizationTime;
  // 造影完成时间
  DateTime radiographyTime;
  // 溶栓开始时间
  DateTime ivctStartTime;

  // 溶栓开始知情时间
  DateTime ivctStartWittingTime;
  // 溶栓知情签署时间
  DateTime ivctEndWittingTime;

  // 参考时长
  int dnt;
  int ont;
  int odt;
  int dpt;
  int drt;

  
  TimePointModel(
      {this.arriveTime,
      this.ctFinishedTime,
      this.diseaseTime,
      this.evtEndWittingTime,
      this.evtStartWittingTime,
      this.ivctEndWittingTime,
      this.ivctStartTime,
      this.ivctStartWittingTime,
      this.punctureTime,
      this.radiographyTime,
      this.revascularizationTime,
      this.visitTime,this.dnt,this.dpt,this.drt,this.odt,this.ont});

  TimePointModel.fromJson(Map<String, dynamic> json) {
    if (json["arriveTime"] != null) {
      arriveTime = DateTime.parse(json["arriveTime"]);
    }
    if (json["visitTime"] != null) {
      visitTime = DateTime.parse(json["visitTime"]);
    }
    if (json["ctFinishedTime"] != null) {
      ctFinishedTime = DateTime.parse(json["ctFinishedTime"]);
    }
    if (json["diseaseTime"] != null) {
      diseaseTime = DateTime.parse(json["diseaseTime"]);
    }
    if (json["evtStartWitting"] != null) {
      evtStartWittingTime = DateTime.parse(json["evtStartWitting"]);
    }
    if (json["evtEndWitting"] != null) {
      evtEndWittingTime = DateTime.parse(json["evtEndWitting"]);
    }
    if (json["punctureTime"] != null) {
      punctureTime = DateTime.parse(json["punctureTime"]);
    }
    if (json["revascularizationTime"] != null) {
      revascularizationTime = DateTime.parse(json["revascularizationTime"]);
    }
    if (json["radiographyTime"] != null) {
      radiographyTime = DateTime.parse(json["radiographyTime"]);
    }
    if (json["ivctStartTime"] != null) {
      ivctStartTime = DateTime.parse(json["ivctStartTime"]);
    }

    if (json["ivctStartWitting"] != null) {
      ivctStartWittingTime = DateTime.parse(json["ivctStartWitting"]);
    }

print(json["ivctEndWitting"]);
    if (json["ivctEndWitting"] != null) {
      ivctEndWittingTime = DateTime.parse(json["ivctEndWitting"]);
    }

    dnt = json["dnt"] as int;
    ont = json["ont"] as int;
    dpt = json["dpt"] as int;
    drt = json["drt"] as int;
    odt = json["odt"] as int;
  }
}
