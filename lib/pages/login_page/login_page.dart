import 'package:cyr/providers/doctor/doctor_provider.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/form/text_input.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'register_page.dart';

// 登录
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 是否同意隐私协议
  bool _isSelectedProtocol;
  bool _enableRegiste;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _isSelectedProtocol = false;
    _enableRegiste = CloudBaseUtil().enableRegister;
    print(_enableRegiste);
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
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
          title: Text("登录"),
          centerTitle: false,
          actions: [
            Visibility(
              visible: _enableRegiste,
              child: TextButton(
                child: const Text(
                  "注册",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  navigateReplacement(context, RegistePage());
                },
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputTextTile(
                  controller: _usernameController,
                  label: "工号",
                  inputType: TextInputType.number,
                  prefix: Icon(Icons.person),
                ),
                InputTextTile(
                    controller: _passwordController,
                    label: "密码",
                    inputType: TextInputType.visiblePassword,
                    isObscure: true,
                    prefix: Icon(Icons.vpn_key)),
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
                SizedBox(
                  height: 24,
                ),
                CustomButton(
                  title: "登录",
                  loading: _loading,
                  onTap: () async {
                    // 检查账号密码是否为空
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    if (username == null || username.trim() == "") {
                      showToast("账号不能为空", context);
                      return;
                    }
                    if (password == null || password.trim() == "") {
                      showToast("密码不能为空", context);
                      return;
                    }
                    // 是否勾选隐私协议
                    if (!_isSelectedProtocol) {
                      showToast("请先同意隐私协议", context);
                      return;
                    }
                    setState(() {
                      _loading = true;
                    });
                    // 登录
                    await Provider.of<DoctorProvider>(context, listen: false)
                        .login(context, username, password);
                    setState(() {
                      _loading = false;
                    });
                  },
                ),
              ],
            )),
      ),
    );
  }
}
