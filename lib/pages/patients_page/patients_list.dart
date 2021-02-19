import 'package:cyr/models/model_list.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:cyr/providers/provider_list.dart';
import 'widgets/patient_card.dart';

class PatientsPage extends StatelessWidget {
  _appBar(context) {
    return AppBar(
      title: Text("新到患者"),
      actions: [],
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
  @override
  Widget build(BuildContext context) {
    PatientProvider patientProvider = Provider.of<PatientProvider>(context);
    return FutureBuilder(
      future: patientProvider.getAllPatients(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Patient> patients = patientProvider.patients;
          if (patients.length == 0) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 54),
                child: Text(
                  "当前暂无患者",
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (BuildContext context, index) {
              var patient = patients[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PatientCard(patient),
              );
            },
          );
        } else {
          return LoadingIndicator();
        }
      },
    );
  }
}
