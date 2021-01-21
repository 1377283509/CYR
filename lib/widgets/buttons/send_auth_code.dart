import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cyr/utils/util_list.dart';


class SendAuthCodeButton extends StatefulWidget {
  // 验证码发送前的验证回调
  final Function beforeAction;
  // 发送验证码回调
  final Function afterAction;
  SendAuthCodeButton({this.beforeAction, this.afterAction});


  @override
  _SendAuthCodeButtonState createState() => _SendAuthCodeButtonState();
}

class _SendAuthCodeButtonState extends State<SendAuthCodeButton> {
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
    bool res = widget.beforeAction();
    if(!res){
      showToast("手机号错误", context);
      return;
    }else{
      widget.afterAction();
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
    super.dispose();
    timer?.cancel();
    timer=null;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: 56,
      textColor:Colors.white,
      color: isButtonEnable?Theme.of(context).primaryColor:Theme.of(context).primaryColor.withOpacity(0.4),
      splashColor: isButtonEnable?Colors.white.withOpacity(0.1):Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      child: Text('$buttonText',style: TextStyle(fontSize: 13,),),
      onPressed:_sendAuthCode,
    );
  }
}
