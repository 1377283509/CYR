import 'package:cyr/providers/patient_detail/evt_provider.dart';
import 'package:cyr/providers/patient_detail/patient_detail_provider.dart';
import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 就诊详情页
class AccidentRecoursePage extends StatelessWidget {
  final String id;
  AccidentRecoursePage({this.id,Key key})
      : assert(id != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => PatientDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FilesProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => VisitRecordProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => VitalSignsProvider(id),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => ECGProvider(id),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => LaboratoryExaminationProvider(id),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => CTProvider(id),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => AspectProvider(id),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => NIHSSProvider(id),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => MRSProvider(id),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => IVCTProvider(id),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => EVTProvider(id),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => SecondLineDoctorProvider(id),
        ),
      ],
      child: Container(),
    );
  }
}


class AccidentRecoursePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}