import 'package:cyr/pages/page_list.dart';
import 'package:cyr/utils/cloudbase/cloudbase.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyr/models/model_list.dart';
import 'package:cloudbase_core/cloudbase_core.dart';

class PatientProvider extends ChangeNotifier {
  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();
  // 所有患者
  List<Patient> _patients = [];
  List<Patient> get patients => _patients;

  // 完成的患者
  List<Patient> _finished = [];
  List<Patient> get finished => _finished;


  // 获取所有患者
  Future<void> getAllPatients(BuildContext context) async {
    try {
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("visit-record", {
        "\$url": "getAllRecords",
      });
      print(res.data);
      if (res.data["code"] == 1) {
        List<Patient> list = [];
        res.data["data"].forEach((e) => {list.add(Patient.fromJson(e))});
        _patients = list;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      print(e);
      showToast(e.toString(), context);
    }
  }

   Future<void> getAllFinishedPatients(BuildContext context) async {
    try {
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("visit-record", {
        "\$url": "getAllFinishedRecords",
      });
      if (res.data["code"] == 1) {
        List<Patient> list = [];
        res.data["data"].forEach((e) => {list.add(Patient.fromJson(e))});
        _finished = list;
      } else {
        showToast(res.data["data"], context);
      }
    } catch (e) {
      showToast(e.toString(), context);
    }
  }




  // 添加患者
  Future<void> createPatient(
      BuildContext context,
      IDCard idCard,
      String pastHistory,
      String chiefComplaint,
      bool isWakeUpStroke,
      DateTime diseaseTime,
      String way) async {
    // 创建患者
    CloudBaseResponse addRes = await _cloudBaseUtil.callFunction("patient", {
      "\$url": "createPatient",
      "name": idCard.name,
      "age": idCard.age,
      "gender": idCard.gender,
      "address": idCard.address,
      "idCard": idCard.id
    });
    if (addRes.data["code"] == 1) {
      // 创建就诊记录
      CloudBaseResponse res =
          await _cloudBaseUtil.callFunction("visit-record", {
        "\$url": "createVisitRecord",
        "patient": addRes.data["data"],
        "chiefComplaint": chiefComplaint,
        "pastHistory": pastHistory,
        "isWakeUpStroke": isWakeUpStroke,
        "diseaseTime": diseaseTime.toString(),
        "wayToHospital": way,
      });
      if (res.data["code"] == 1) {
        // 发送消息
        await _cloudBaseUtil.callFunction("message", {
          "\$url": "sendNewPatientMessage",
          "sendTime": DateTime.now().toIso8601String(),
          "visitRecord": res.data["data"],
          "content": "有新的患者，请各部门提前做好准备",
          "patientName": idCard.name
        });
        navigateReplacement(context, ResultPage(content: "创建成功",));
      } else {
        showAlertDialog(context, addRes.data["data"]);
      }
    } else {
      showAlertDialog(context, addRes.data["data"]);
    }
  }

  // 搜索患者
  Future<List<IDCard>> search(String name) async {
    List<IDCard> list = [];
    try {
      CloudBaseResponse res = await _cloudBaseUtil
          .callFunction("patient", {"\$url": "search", "name": name});
      List result = res.data["data"];
      for (int i = 0; i < result.length; i++) {
        list.add(IDCard.fromJson(result[i]));
      }
      return list;
    } catch (e) {
      return list;
    }
  }
}
