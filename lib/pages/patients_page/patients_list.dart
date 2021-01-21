import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cyr/providers/provider_list.dart';
import 'widgets/patient_card.dart';

class PatientsPage extends StatelessWidget {
  _appBar(context) {
    return AppBar(
      title: Text(
        "所有患者",
        style: Theme.of(context).textTheme.headline1,
      ),
      actions: [
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar(context),
      body: PatientsPageBody(),
    );
  }
}

class PatientsPageBody extends StatefulWidget {
  @override
  _PatientsPageBodyState createState() => _PatientsPageBodyState();
}

class _PatientsPageBodyState extends State<PatientsPageBody> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    PatientProvider patientProvider = Provider.of<PatientProvider>(context);
    return CustomRefresh(
        onRefresh: ()async{
          await patientProvider.getAllPatients(context);
        },
        child: ListView.builder(
          controller: _controller,
          itemCount: patientProvider.patients.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            var patient = patientProvider.patients[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: PatientCard(patient),
            );
          },
        ));
  }
}
