import 'package:cyr/models/model_list.dart';
import 'package:cyr/models/record/CT.dart';
import 'package:cyr/models/record/ECG.dart';
import 'package:cyr/models/record/laboratory_examination.dart';
import 'package:cyr/models/record/second_line_doctor.dart';
import 'package:flutter/cupertino.dart';

class PatientDetailProvider extends ChangeNotifier{
  // 患者信息
  VisitRecordModel _patientInfo = VisitRecordModel();
  VisitRecordModel get patientInfo => _patientInfo;

  // 手环信息
  String get bangle => _patientInfo?.bangle??null;

  // 生命体征
  VitalSignsModel _vitalSigns = VitalSignsModel();
  VitalSignsModel get vitalSigns => _vitalSigns;

  // 发病时间
  DateTime get diseaseTime => _patientInfo?.diseaseTime??null;

  // 就诊时间
  DateTime get visitTime => _patientInfo?.visitTime??null;

  ECGModel _ecg = ECGModel();
  ECGModel get ecg => _ecg;

  // CT
  CTModel _ct = CTModel();
  CTModel get ct => _ct;

  // 化验
  LaboratoryExamination _laboratoryExamination = LaboratoryExamination();
  LaboratoryExamination get laboratoryExamination => _laboratoryExamination;

  // 二线医生
  SecondLineDoctorModel _secondLineDoctor;
  SecondLineDoctorModel get secondLineDoctor => _secondLineDoctor;


  // 获取就诊记录
  Future<void> getVisitRecord(BuildContext context)async{
  }

  // 获取生命体征
  Future<void> getVitalSigns()async{

  }





}