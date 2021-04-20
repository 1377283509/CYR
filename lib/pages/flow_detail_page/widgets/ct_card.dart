// CT 信息
import 'package:cyr/models/record/CT.dart';
import 'package:cyr/pages/flow_detail_page/widgets/card_title.dart';
import 'package:cyr/pages/flow_detail_page/widgets/kv_cell.dart';
import 'package:cyr/providers/patient_detail/ct_provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:cyr/widgets/image_card/image_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CTCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardTitle("CT"),
          const CustomDivider(),
          FutureBuilder(
              future: Provider.of<CTProvider>(context, listen: false)
                  .getCT(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<CTProvider>(
                    builder: (_, ctProvider, __) {
                      CTModel ctModel = ctProvider.ctModel;
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            KVCell("开单时间", formatTime(ctModel.orderTime)),
                            const CustomDivider(),
                            KVCell("开单责任医生",
                                "${ctModel.orderDoctorName ?? '暂无'}${ctModel.orderDoctorName ?? ''}"),
                            const CustomDivider(),
                            KVCell("到达化验室", formatTime(ctModel.arriveTime)),
                            const CustomDivider(),
                            KVCell("结果回报", formatTime(ctModel.endTime)),
                            const CustomDivider(),
                            KVCell("责任医生",
                                "${ctModel.doctorName ?? '暂无'}${ctModel.doctorId ?? ''}"),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: ctModel.images ??
                                    []
                                        .map((e) => Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: ImageCard(e)))
                                        .toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: CupertinoActivityIndicator(),
                );
              }),
        ],
      ),
    );
  }
}
