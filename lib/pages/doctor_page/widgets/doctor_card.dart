import 'package:cyr/config/config_list.dart';
import 'package:cyr/pages/page_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/custom_tile/navigate_tile.dart';
import 'package:flutter/material.dart';
import 'package:cyr/models/model_list.dart';

class DoctorCard extends StatelessWidget {
  final bool isCallPhone;

  final Doctor doctor;
  const DoctorCard(this.doctor, {this.isCallPhone = false, Key key})
      : super(key: key);

  _editPhone(BuildContext context) async {
    // 检测是否支持本地验证
    if (!await canUseLocalAuth()) {
      showToast("当前设备不支持本地验证，请联系管理员进行修改", context);
      return;
    }
    bool res = await localAuth();
    // 验证成功修改手机号
    if (res) {
      navigateTo(context, EditPhonePage());
    } else {
      showToast("身份验证失败", context);
    }
  }

  _callPhone(String phone) async {
    if (phone != null) {
      await launchPhone(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 头像、年龄、姓名
            Builder(
              builder: (BuildContext context) => ListTile(
                leading: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: DefaultAvatar(
                      isMale: doctor.gender == "男",
                    )),
                title: Text(
                  doctor.name,
                  style: const TextStyle(
                    fontSize: 16,
                      letterSpacing: 1),
                ),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      color: doctor.gender == "男"
                          ? Colors.blue
                          : Colors.pinkAccent,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text("${doctor.age}岁"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.qr_code),
                  onPressed: () async {
                    showQrCode(context, doctor.id);
                  },
                ),
              ),
            ),
            // 医院
            NavigateTile(
              icon: const Icon(
                Icons.business,
                color: Colors.blue,
              ),
              title: "大同市第五人民医院",
            ),
            // 科室 职位
            NavigateTile(
              icon: const Icon(
                Icons.local_hospital,
                color: Colors.red,
              ),
              title: "${doctor.department}   ${doctor.job}",
            ),

            // 电话
            InkWell(
              onTap: () async {
                isCallPhone
                    ? await _callPhone(doctor.phone)
                    : await _editPhone(context);
              },
              child: NavigateTile(
                icon: const Icon(
                  Icons.phone,
                  color: Colors.indigo,
                ),
                title: "${doctor.phone}",
                showTrailing: true,
              ),
            ),
          ],
        ));
  }
}

// 网络头像

// 默认头像
class DefaultAvatar extends StatelessWidget {
  final bool isMale;
  DefaultAvatar({this.isMale = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
          isMale ? AssetImages.avatar_male : AssetImages.avatar_female),
    );
  }
}
