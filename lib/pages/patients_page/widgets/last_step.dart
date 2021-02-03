import 'package:cyr/models/model_list.dart';
import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LastStepCard extends StatelessWidget {

  final List<String> _steps = [
    "神经内科",
    "重症监护",
    "急诊留观",
    "院间转诊",
    "回家",
    "死亡",
    "其他",
  ];


  @override
  Widget build(BuildContext context) {
    return Consumer<VisitRecordProvider>(
      builder: (_, provider,__){
        return NoExpansionCard(
          title:"去向",
          trailing: Text(provider.lastStep??"点击选择"),
          onTap: ()async{
            if(provider.lastStep != null){
              return;
            }
            List<String> res = await showModalBottomSheet(
                context: context,
                builder: (BuildContext context){
                  return Container(
                    child: ListView.separated(
                      itemCount: _steps.length,
                      separatorBuilder: (context, index){
                        return CustomDivider();
                      },
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(_steps[index]),
                          onTap: (){
                            Navigator.of(context).pop([_steps[index]]);
                          },
                          trailing: const Icon(Icons.keyboard_arrow_right, color:Colors.grey),
                        );
                      },
                    ),
                  );
                }
            );
            if(res!=null){
              await provider.setLastStep(context, res[0]);
            }
          },
        );
      },
    );
  }
}
