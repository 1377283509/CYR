import 'package:cyr/pages/login_page/login_page.dart';
import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/form/text_input.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// 注册
class RegistePage extends StatefulWidget {
  @override
  _RegistePageState createState() => _RegistePageState();
}

class _RegistePageState extends State<RegistePage> {
  // 密码
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  // 姓名
  final TextEditingController _nameController = TextEditingController();
  // 手机号
  final TextEditingController _phoneController = TextEditingController();
  // 性别
  String _gender;
  // 年龄
  final TextEditingController _ageController = TextEditingController();
  // 科室
  String _department;
  // 职位
  String _job;
  // 职工号
  final TextEditingController _idController = TextEditingController();
  // 是否同意隐私协议
  bool _isSelectedProtocol;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _isSelectedProtocol = false;
  }

  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("注册"),
          centerTitle: false,
          actions: [
            TextButton(
              child: const Text(
                "登录",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                navigateReplacement(context, LoginPage());
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 姓名年龄
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InputTextTile(
                          controller: _nameController,
                          label: "姓名",
                          inputType: TextInputType.text,
                          prefix: Icon(Icons.person)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: InputTextTile(
                        controller: _ageController,
                        label: "年龄",
                        inputType: TextInputType.number,
                        prefix: Icon(Icons.confirmation_num),
                      ),
                    ),
                  ],
                ),

                // 性别，科室，职位
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: _buildPopupButton(_gender ?? "性别", ["男", "女"],
                              (v) {
                            setState(() {
                              _gender = v;
                            });
                          })),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          flex: 5,
                          child: _buildPopupButton(_department ?? "科室", [
                            "医院",
                            "神经内科",
                            "急救中心",
                            "急诊科",
                            "影像科",
                            "检验科",
                            "主管护师"
                          ], (v) {
                            setState(() {
                              _department = v;
                            });
                          })),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          flex: 5,
                          child: _buildPopupButton(_job ?? "职位", [
                            "主任医师",
                            "副主任医师",
                            "主治医师",
                            "医师",
                            "技师",
                            "护士",
                            "护士长",
                            "副护士长",
                            "主管护师",
                          ], (v) {
                            setState(() {
                              _job = v;
                            });
                          })),
                    ],
                  ),
                ),
                // 电话
                InputTextTile(
                  controller: _phoneController,
                  label: "手机号",
                  inputType: TextInputType.phone,
                  prefix: Icon(Icons.phone),
                ),

                // 工号
                InputTextTile(
                  controller: _idController,
                  label: "工号",
                  inputType: TextInputType.number,
                  prefix: Icon(Icons.person),
                ),
                // 密码
                InputTextTile(
                    controller: _passwordController,
                    label: "密码",
                    inputType: TextInputType.visiblePassword,
                    isObscure: true,
                    prefix: Icon(Icons.vpn_key)),

                InputTextTile(
                    controller: _confirmPasswordController,
                    label: "确认密码",
                    inputType: TextInputType.visiblePassword,
                    isObscure: true,
                    prefix: Icon(Icons.vpn_key)),

                // 隐私协议
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(_isSelectedProtocol
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank),
                        color: _isSelectedProtocol ? Colors.green : Colors.grey,
                        onPressed: () {
                          setState(() {
                            _isSelectedProtocol = !_isSelectedProtocol;
                          });
                        },
                      ),
                      TextButton(
                        child: Text(
                          "隐私协议",
                        ),
                        onPressed: () {
                          launchUrl("http://www.cyautomation.com/privacy.html");
                        },
                      ),
                    ],
                  ),
                ),
                // 注册按钮
                _buildButton()
              ],
            )),
      ),
    );
  }

  bool checkString(String str) {
    return str != null && str != null;
  }

  // 注册按钮
  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: CustomButton(
        loading: loading,
        title: "注册",
        onTap: () async {
          String id = _idController.text.trim();
          String password = _passwordController.text;
          String confirmPassword = _confirmPasswordController.text;
          String name = _nameController.text.trim();
          String age = _ageController.text.trim();
          String phone = _phoneController.text.trim();
          if (!checkString(id) ||
              !checkString(password) ||
              !checkString(confirmPassword) ||
              !checkString(name) ||
              !checkString(phone) ||
              !checkString(age) ||
              _department == null ||
              _gender == null ||
              _job == null) {
            showToast("请完整填写信息", context);
            return;
          }

          if (password != confirmPassword) {
            showToast("密码不一致", context);
            return;
          }

          // 是否勾选隐私协议
          if (!_isSelectedProtocol) {
            showToast("请先同意隐私协议", context);
            return;
          }
          setState(() {
            loading = true;
          });

          // 注册
          await Provider.of<DoctorProvider>(context, listen: false).register(
              context,
              name,
              password,
              _department,
              _job,
              _gender,
              int.parse(age),
              id,
              phone);
          setState(() {
            loading = false;
          });
        },
      ),
    );
  }

  // 弹出按钮样式
  Widget _buildPopupButton(
      String value, List<String> values, Function onSelect) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12)),
      child: PopupMenuButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            )
          ],
        ),
        onSelected: (v) {
          onSelect(v);
        },
        itemBuilder: (BuildContext context) {
          return values
              .map((e) => PopupMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList();
        },
      ),
    );
  }
}
