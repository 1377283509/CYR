import 'package:cyr/models/model_list.dart';
import 'package:cyr/pages/input_page/input_nihss_page.dart';
import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/pages/patients_page/widgets/single_tile.dart';
import 'package:cyr/providers/patient_detail/nihss_provider.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/custom_tile/expansion_card.dart';
import 'package:cyr/widgets/custom_tile/no_expansion_card.dart';
import 'package:cyr/widgets/icon/state_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NIHSSCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftIcon(Consumer<NIHSSProvider>(
              builder: (_,provider,__){
                return StateIcon(provider.endTime!=null);
              },
            )),
          ),
          Expanded(
            flex: 8,
            child: FutureBuilder(
              future: Provider.of<NIHSSProvider>(context, listen: false)
                  .getNIHSS(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<NIHSSProvider>(
                    builder: (_, provider, __) {
                      return ExpansionCard(
                        title: "NIHSS评分",
                        children: [
                          // 有通知时间，说明已经通知
                          SingleTile(
                            title: "结果",
                            value: provider.result,
                            buttonLabel: "输入",
                            onTap: () async {
                              DateTime startTime = DateTime.now();
                              Doctor doctor = Provider.of<DoctorProvider>(
                                      context,
                                      listen: false)
                                  .user;
                              List<int> res = await navigateTo(context, InputNIHSSPage(startTime));

                              print(res);

                              // 如果有输入
                              if (res != null && res.length > 0) {
                                await provider.setResult(context, startTime,
                                    doctor.idCard, doctor.name, "${res[0]}分");
                              }
                            },
                          ),
                          SingleTile(
                            title: "完成时间",
                            value: formatTime(provider.endTime),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return NoExpansionCard(
                    title: "NIHSS评分",
                    trailing: CupertinoActivityIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
