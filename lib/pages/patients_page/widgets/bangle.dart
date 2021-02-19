import 'package:cyr/pages/patients_page/widgets/left_icon.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/qr_code/qr_code_util.dart';
import 'package:cyr/widgets/custom_tile/no_expansion_card.dart';
import 'package:cyr/widgets/icon/round_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cyr/utils/time_format/time_format.dart';

class BangleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftIcon(RoundIcon(Icons.watch, Colors.orange)),
          ),
          Expanded(
              flex: 8,
              child: NoExpansionCard(
                title: "手环信息",
                trailing: Consumer<VisitRecordProvider>(
                  builder: (_, provider, __) {
                    if (provider.bangle == null) {
                      return IconButton(
                        icon: Icon(Icons.qr_code_scanner),
                        onPressed: () async {
                          String res = await scan(context);
                          if (res != null) {
                            await provider.setBangle(context, res);
                          }
                        },
                      );
                    }
                    return Text(
                      "${formatTime(provider.arriveTime)}    已绑定",
                      style: TextStyle(color: Colors.grey),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
