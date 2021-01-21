import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyr/models/model_list.dart';


class RecordProvider extends ChangeNotifier {
  CloudBaseUtil _cloudBase;
  RecordProvider() {
    _cloudBase = CloudBaseUtil();
  }

  VisitRecordModel _visitRecord = VisitRecordModel();
  VisitRecordModel get visitRecord => _visitRecord;



}
