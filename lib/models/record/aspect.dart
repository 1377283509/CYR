class AspectModel {
  String id;
  String visitRecordId;
  int totalScore;
  int score;
  String result;
  DateTime startTime;
  DateTime endTime;
  String doctorId;
  String doctorName;
  bool state;

  AspectModel(
      {this.id,
      this.startTime,
      this.endTime,
      this.doctorId,
      this.doctorName,
      this.totalScore,
      this.score,
      this.result,
      this.visitRecordId,
      this.state});

  factory AspectModel.fromJson(Map<String, dynamic> json) {
    return AspectModel(
      id: json["_id"] as String,
      visitRecordId: json["visitRecordId"] as String,
      result: json["result"] as String,
      score: json["score"] as int,
      totalScore: json["totalScore"] as int,
      doctorId: json["doctorId"] as String,
      doctorName: json["doctorName"] as String,
      startTime:
          json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
      endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
    );
  }
}
