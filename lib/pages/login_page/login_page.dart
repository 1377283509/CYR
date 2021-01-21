import 'package:cyr/pages/home_page/home_page.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/buttons/normal_button.dart';
import 'package:cyr/widgets/dialog/alert_dialog.dart';
import 'package:cyr/widgets/divider/blank_space_widget.dart';
import 'package:cyr/widgets/form/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

// 登录
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登 录"),
        centerTitle: false,
        actions: [
          Consumer<DoctorProvider>(
            builder: (_, userProvider, __){
              return TextButton(
                child: Text("设备码", style: TextStyle(color: Colors.white),),
                onPressed: ()async{
                  String code = await getDeviceCode();
                  Clipboard.setData(ClipboardData(text: code));
                  showToast("设备码已复制到剪切板", context);
                },
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputTextTile(
                controller: _controller,
                label: "请输入手机号",
                prefix: Icon(Icons.phone),
                placeHolder: "请输入手机号",
                inputType: TextInputType.number,
              ),
              BlankSpace(),
              Consumer<DoctorProvider>(
                builder: (_, userProvider, __){
                  return CustomButton(onTap: () async {
                    if(!verifyPhone(_controller.text)){
                      showToast("手机号格式错误", context);
                      return;
                    }
                    setState(() {
                      _isLoading = true;
                    });
                    // String res = await userProvider.login();
                    String res;
                    setState(() {
                      _isLoading = false;
                    });
                    if(res == "OK"){
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (BuildContext context)=>HomePage()
                      ));
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return CustomAlertDialog(res);
                        }
                    );
                  }, title: "登录");
                },),
              BlankSpace(),
              _isLoading?CupertinoActivityIndicator():Container(),
            ],
          ),
        ),
      ),
    );
  }
}
