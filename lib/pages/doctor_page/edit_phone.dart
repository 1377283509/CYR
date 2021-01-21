import 'dart:async';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/buttons/send_auth_code.dart';
import 'package:flutter/material.dart';
import 'package:cyr/widgets/widget_list.dart';

class EditPhonePage extends StatefulWidget {
  @override
  _EditPhonePageState createState() => _EditPhonePageState();
}

class _EditPhonePageState extends State<EditPhonePage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  bool  isButtonEnable=true;
  String buttonText='发送验证码';
  int count=60;
  Timer timer;


  void _initTimer(){
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if(count==0){
          timer.cancel();             //倒计时结束取消定时器
          isButtonEnable=true;        //按钮可点击
          count=60;                   //重置时间
          buttonText='发送验证码';     //重置按钮文本
        }else{
          buttonText='重新发送($count)';  //更新文本内容
        }
      });
    });
  }

  _sendAuthCode(){
    bool res = verifyPhone(_phoneController.text);
    if(!res){
      showToast("手机号错误", context);
      return;
    }else{
      // TODO: 发送验证码
      setState(() {
        if(isButtonEnable){
          _initTimer();
          isButtonEnable=false;
          return null;
        }else{
          return null;
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();      //销毁计时器
    timer=null;
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
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
            title: Text("更改绑定手机"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 手机号输入框
                  InputTextTile(
                      controller: _phoneController,
                      placeHolder: "请输入手机号",
                      label: "手机号",
                      inputType: TextInputType.phone,
                      autoFocus: true,
                      prefix: Icon(Icons.phone),
                      onSubmitted: (v) {
                      }),
                  SizedBox(height: 6,),
                  // 验证码
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: InputTextTile(
                              controller: _codeController,
                              label: "验证码",
                              placeHolder: "请输入验证码",
                              inputType: TextInputType.number,
                              prefix: Icon(Icons.code),
                              onSubmitted: () {}),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          flex: 2,
                          child: SendAuthCodeButton(
                            beforeAction: (){
                              return verifyPhone(_phoneController.text);
                            },
                            afterAction: (){
                              // TODO： 发送验证码
                              print("向${_phoneController.text}发送验证码");
                            },
                          )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 36,),
                  // button
                  Container(
                    child: CustomButton(
                      title: "验证",
                      onTap: (){
                        // 验证手机号和验证码
                        print("修改手机");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
