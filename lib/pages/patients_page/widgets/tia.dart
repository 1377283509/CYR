import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cyr/providers/patient_detail/visit_record_provider.dart';
import 'package:cyr/widgets/widget_list.dart';
import './left_icon.dart';
import './bool_card.dart';
import 'package:cyr/utils/permission/permission.dart';

class TIAConfirmCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftIcon(RoundIcon(Icons.compare_arrows, Colors.orange)),
          ),
          Expanded(
            flex: 8,
            child: Consumer<VisitRecordProvider>(
              builder: (_, provider, __) {
                return NoExpansionCard(
                  title: "短暂性脑出血发作",
                  onTap: () async {
                    String department =
                        Provider.of<DoctorProvider>(context, listen: false)
                            .user
                            .department;
                    if (!permissionHandler(PermissionType.CI, department)) {
                      showToast("神经内科权限", context);
                      return;
                    }
                    await provider.setTIA(context);
                  },
                  trailing: BoolCard(
                    state: provider.isTIA,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
