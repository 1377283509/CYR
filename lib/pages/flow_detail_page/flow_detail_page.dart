import 'package:cyr/pages/flow_detail_page/widgets/aspect_card.dart';
import 'package:cyr/pages/flow_detail_page/widgets/ct_card.dart';
import 'package:cyr/pages/flow_detail_page/widgets/disease_card.dart';
import 'package:cyr/pages/flow_detail_page/widgets/ecg_card.dart';
import 'package:cyr/pages/flow_detail_page/widgets/evt_card.dart';
import 'package:cyr/pages/flow_detail_page/widgets/ivct_card.dart';
import 'package:cyr/pages/flow_detail_page/widgets/patient_detail_card.dart';
import 'package:cyr/pages/flow_detail_page/widgets/second_line_doctor.dart';
import 'package:cyr/pages/flow_detail_page/widgets/visit_info.dart';
import 'package:cyr/pages/flow_detail_page/widgets/laboratory_examination.dart';
import 'package:cyr/pages/flow_detail_page/widgets/vital_signs_card.dart';
import 'package:cyr/pages/flow_detail_page/widgets/mrs_card.dart';
import 'package:cyr/pages/patients_page/quility_control_page.dart';
import 'package:cyr/providers/patient_detail/evt_provider.dart';
import 'package:cyr/providers/patient_detail/quility_control_provider.dart';
import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 就诊流程详情页
class FlowDetailPage extends StatelessWidget {
  final String id;
  final String bangle;
  FlowDetailPage({this.id, this.bangle, Key key})
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
      child: FlowDetailPageBody(
        id: id,
        bangle: bangle,
      ),
    );
  }
}

class FlowDetailPageBody extends StatefulWidget {
  // 就诊记录id
  final String id;
  final String bangle;
  FlowDetailPageBody({this.id, this.bangle, Key key})
      : assert(id != null || bangle != null),
        super(key: key);

  @override
  _FlowDetailPageBodyState createState() => _FlowDetailPageBodyState();
}

class _FlowDetailPageBodyState extends State<FlowDetailPageBody>
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
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_outlined,
              size: 36,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Consumer<VisitRecordProvider>(
            builder: (_, provider, __) {
              return provider.patientName == null
                  ? CupertinoActivityIndicator()
                  : Text(provider.patientName);
            },
          ),
          centerTitle: true,
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.table_chart_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    String id =
                        Provider.of<VisitRecordProvider>(context, listen: false)
                            .visitRecordModel
                            .id;
                    navigateTo(
                        context,
                        ChangeNotifierProvider(
                          create: (BuildContext context) =>
                              QuilityControlProvider(),
                          child: QuilityControlPage(id),
                        ));
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
          child: FutureBuilder(
            future: visitRecordProvider.getVisitRecord(
                context, widget.id, widget.bangle),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // 患者信息
                    PatientDetailCard(),
                    const SizedBox(
                      height: 8,
                    ),
                    // 发病信息
                    DiseaseCard(),
                    const SizedBox(
                      height: 8,
                    ),
                    // 生命体征
                    VitalSignsCard(),
                    const SizedBox(
                      height: 8,
                    ),
                    // 就诊信息
                    VisitInfo(),
                    const SizedBox(
                      height: 8,
                    ),
                    // ECG
                    ECGCard(),
                    const SizedBox(
                      height: 8,
                    ),
                    // 化验检查
                    LaboratoryExaminationCard(),
                    const SizedBox(
                      height: 8,
                    ),
                    // CT
                    CTCard(),
                    const SizedBox(
                      height: 8,
                    ),
                    // 二线信息
                    SecondLineDoctorCard(),
                    const SizedBox(
                      height: 8,
                    ),

                    Visibility(
                      visible: Provider.of<VisitRecordProvider>(context).isCI ??
                          false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // MRS评分
                          MRSCard(),
                          const SizedBox(
                            height: 8,
                          ),
                          // Aspect评分
                          AspectCard(),
                          const SizedBox(
                            height: 8,
                          ),
                          // 静脉溶栓
                          IVCTCard(),
                          const SizedBox(
                            height: 8,
                          ),
                          // 血管内治疗
                          Visibility(
                            visible: Provider.of<VisitRecordProvider>(context)
                                    .isEVT ??
                                false,
                            child: EVTCard(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
