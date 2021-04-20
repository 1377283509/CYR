import 'package:cyr/models/record/laboratory_examination.dart';
import 'package:cyr/pages/flow_detail_page/widgets/card_title.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/patient_detail/laboratory_examination_provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:cyr/widgets/image_card/image_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaboratoryExaminationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("化验检查"),
          FutureBuilder(
            future: Provider.of<LaboratoryExaminationProvider>(context,
                    listen: false)
                .getByVisitRecord(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<LaboratoryExaminationProvider>(
                  builder: (_, laProvider, __) {
                    LaboratoryExamination laboratoryExamination =
                        laProvider.laboratoryExamination;
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CustomDivider(),
                          KVCell("抽血时间",
                              formatTime(laboratoryExamination.bloodTime)),
                          const CustomDivider(),
                          KVCell("抽血责任医生",
                              "${laboratoryExamination.drawBloodDoctorName ?? '暂无'}${laboratoryExamination.drawBloodDoctorId}"),
                          const CustomDivider(),
                          KVCell(
                              "到达化验室",
                              formatTime(
                                  laboratoryExamination.arriveLaboratoryTime)),
                          const CustomDivider(),
                          KVCell("结果上报",
                              formatTime(laboratoryExamination.endTime)),
                          const CustomDivider(),
                          KVCell("责任医生",
                              "${laboratoryExamination.examinationDoctorName ?? '暂无'}${laboratoryExamination.examinationDoctorId ?? ''}"),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: laboratoryExamination.images ??
                                  [].map((e) => ImageCard(e)).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
