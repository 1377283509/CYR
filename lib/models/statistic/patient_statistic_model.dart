class PatientStatisticModel {
  String id;
  int year;
  int month;
  int patientsCount;
  int ivctCount;
  int evtCount;
  int dntAverageTime;
  int dntTimeOutCount;
  int deathCount;

  PatientStatisticModel(
      {this.id,
      this.year,
      this.month,
      this.patientsCount,
      this.ivctCount,
      this.evtCount,
      this.dntAverageTime,
      this.dntTimeOutCount,
      this.deathCount});

  factory PatientStatisticModel.fromJson(Map<String, dynamic> json) {
    return PatientStatisticModel(
      id: json["_id"] as String,
      year: json["year"] as int,
      month: json["month"] as int,
      patientsCount: json["patientsCount"] as int,
      ivctCount: json["ivctCount"] as int,
      evtCount: json["evtCount"] as int,
      dntAverageTime: json["dntAverageTime"] as int,
      dntTimeOutCount: json["dntTimeOutCount"] as int,
      deathCount: json["deathCount"] as int,
    );
  }
}
