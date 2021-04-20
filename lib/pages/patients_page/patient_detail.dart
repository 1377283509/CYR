import 'package:cyr/pages/patients_page/quility_control_page.dart';
import 'package:cyr/pages/patients_page/widgets/aspect.dart';
import 'package:cyr/pages/patients_page/widgets/ct.dart';
import 'package:cyr/pages/patients_page/widgets/ecg.dart';
import 'package:cyr/pages/patients_page/widgets/laboratory_examination.dart';
import 'package:cyr/pages/patients_page/widgets/second_line_doctor.dart';
import 'package:cyr/providers/patient_detail/evt_provider.dart';
import 'package:cyr/providers/patient_detail/quility_control_provider.dart';
import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/navigator/custom_navigator.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/bangle.dart';
import 'widgets/bind_doctor.dart';
import 'widgets/ci.dart';
import 'widgets/evt.dart';
import 'widgets/ivct.dart';
import 'widgets/mRS.dart';
import 'widgets/last_step.dart';
import 'widgets/patient_info.dart';
import 'widgets/time_info.dart';
import 'widgets/vital_signs.dart';
import 'widgets/disease_info.dart';
import 'widgets/tia.dart';

// 就诊详情页
class PatientDetailPage extends StatelessWidget {
  final String id;
  final String bangle;
  PatientDetailPage({this.id, this.bangle, Key key})
      : assert(id != null || bangle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
      child: PatientDetailPageBody(
        id: id,
        bangle: bangle,
      ),
    );
  }
}

class PatientDetailPageBody extends StatefulWidget {
  // 就诊记录id
  final String id;
  final String bangle;
  PatientDetailPageBody({this.id, this.bangle, Key key})
      : assert(id != null || bangle != null),
        super(key: key);

  @override
  _PatientDetailPageBodyState createState() => _PatientDetailPageBodyState();
}

class _PatientDetailPageBodyState extends State<PatientDetailPageBody>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey scaffoldKey = GlobalKey();
    VisitRecordProvider visitRecordProvider =
        Provider.of<VisitRecordProvider>(context, listen: false);
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Consumer<VisitRecordProvider>(
            builder: (_, provider, __) {
              return provider.patientName == null
                  ? CupertinoActivityIndicator()
                  : Text(provider.patientName);
            },
          ),
          centerTitle: true,
          actions: [
            TextButton(
              child: Text(
                "质控",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                String id =
                    Provider.of<VisitRecordProvider>(context, listen: false)
                        .visitRecordModel
                        .id;
                if (id == null && widget.id == null) {
                  showToast("加载中", context);
                  return;
                }
                navigateTo(
                    context,
                    ChangeNotifierProvider<QuilityControlProvider>(
                      create: (context) => QuilityControlProvider(),
                      child: QuilityControlPage(widget.id ?? id),
                    ));
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
          child: FutureBuilder<bool>(
            future: visitRecordProvider.getVisitRecord(
                context, widget.id, widget.bangle),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Visibility(
                        visible: Provider.of<VisitRecordProvider>(context,
                                    listen: true)
                                .lastStep ==
                            null,
                        child: Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: TimeInfoCard(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 手环信息
                              BangleCard(),

                              // 绑定主治医生
                              BindDoctor(),

                              // 二线医生
                              SecondLineDoctor(),

                              // 患者信息
                              PatientInfoCard(),

                              // 发病信息
                              DiseaseInfoCard(),

                              // 生命体征
                              VitalSignsCard(),

                              // 心电图
                              EctCard(),

                              // 化验检查
                              LaboratoryExaminationCard(),

                              // CT检查
                              CTCard(),

                              // 是否缺血性脑卒中
                              CIConfirmCard(),

                              Consumer<VisitRecordProvider>(
                                builder: (_, provider, __) {
                                  return Visibility(
                                    visible: provider.isCI,
                                    child: TIAConfirmCard(),
                                  );
                                },
                              ),

                              // ASPECT评分
                              Consumer<VisitRecordProvider>(
                                builder: (_, provider, __) {
                                  return Visibility(
                                    visible: provider.isCI,
                                    child: AspectCard(),
                                  );
                                },
                              ),

                              // mRS评估
                              Consumer<VisitRecordProvider>(
                                builder: (_, provider, __) {
                                  return Visibility(
                                    visible: provider.isCI,
                                    child: MRSCard(),
                                  );
                                },
                              ),

                              Consumer<VisitRecordProvider>(
                                builder: (_, provider, __) {
                                  return Visibility(
                                    visible: provider.isCI,
                                    child: IVCTCard(),
                                  );
                                },
                              ),

                              // 血管内治疗

                              Consumer<VisitRecordProvider>(
                                builder: (_, provider, __) {
                                  return Visibility(
                                    visible: provider.isCI,
                                    child: EVTConfirmCard(),
                                  );
                                },
                              ),

                              Consumer<VisitRecordProvider>(
                                builder: (_, provider, __) {
                                  return Visibility(
                                    visible: provider.isEVT && provider.isCI,
                                    child: EVTCard(),
                                  );
                                },
                              ),
                              // 去向
                              LastStepCard()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return LoadingIndicator();
              }
            },
          ),
        ));
  }
}
