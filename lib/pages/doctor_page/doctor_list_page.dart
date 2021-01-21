import 'package:cyr/models/model_list.dart';
import 'package:cyr/utils/dialog/show_dialog.dart';
import 'package:cyr/widgets/refresh/custom_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cyr/providers/provider_list.dart';

class DoctorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("医护人员"),
      ),
      body: DoctorListPageBody(),
    );
  }
}

class DoctorListPageBody extends StatefulWidget {
  @override
  _DoctorListPageBodyState createState() => _DoctorListPageBodyState();
}

class _DoctorListPageBodyState extends State<DoctorListPageBody> {
  Widget _buildDoctorCard(Doctor doctor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          onTap: () async {
            bool res = await showConfirmDialog(context, "主治医生选择确认",
                content:
                    "姓名：${doctor.name}  \n性别：${doctor.gender}  \n年龄：${doctor.age}岁  \n当前：${doctor.state ? '在岗' : '休息'}");
            if (res) {
              Navigator.pop(context, [doctor.id, doctor.name]);
            }
          },
          tileColor: doctor.state ? Colors.green[600] : Colors.red[700],
          leading: Icon(
            doctor.state ? Icons.local_hospital : Icons.local_cafe,
            color: Colors.white,
          ),
          title: Text(
            doctor.name,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "${doctor.gender}  ${doctor.age}岁  ${doctor.job}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTile(String name, int count, List list) {
    return ExpansionTile(
        key: ValueKey(name),
        title: Text(
          name,
          style: const TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          "总 $count 人",
          style: const TextStyle(color: Colors.black54, fontSize: 14),
        ),
        children: list.map((e) {
          Doctor doctor = Doctor.fromJson(e);
          return _buildDoctorCard(doctor);
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    return Consumer<DoctorProvider>(
      builder: (_, provider, __) {
        return CustomRefresh(
            onRefresh: () async {
              await provider.getAllDoctors(context);
            },
            child: ListView.builder(
              itemCount: doctorProvider.doctorList.length,
              itemBuilder: (BuildContext context, index) {
                Map item = doctorProvider.doctorList[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: _buildExpansionTile(
                      item["_id"], item["count"], item["list"]),
                );
              },
            ));
      },
    );
  }
}
