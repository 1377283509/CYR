import 'package:cyr/widgets/buttons/normal_button.dart';
import 'package:flutter/material.dart';

enum WittingUtils {
  FACE_TO_FACE,
  PHONE,
}

Map<WittingUtils, String> utilsName = {
  WittingUtils.FACE_TO_FACE: '当面谈话',
  WittingUtils.PHONE: "电话谈话"
};

class WittingUtilList extends StatelessWidget {
  final Function onTap;

  WittingUtilList({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: RadioListTile(
              title: Text(utilsName[WittingUtils.FACE_TO_FACE]),
              tileColor: Colors.white,
              value: WittingUtils.FACE_TO_FACE,
              groupValue: "witting_utils",
              onChanged: (util) {
                onTap(utilsName[util]);
              },
            ),
          ),
          SizedBox(height: 12,),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: RadioListTile(
              title: Text(utilsName[WittingUtils.PHONE]),
              value: WittingUtils.PHONE,
              tileColor: Colors.white,
              groupValue: "witting_utils",
              onChanged: (util) {
                onTap(utilsName[util]);
              },
            ),
          ),
          SizedBox(height: 32,),
          CustomButton(
            backgroundColor: Colors.white,
              textColor: Colors.indigo,
              onTap: () {
                Navigator.pop(context);
              },
              title: "取消")
        ],
      ),
    );
  }
}
