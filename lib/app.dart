import 'package:cyr/config/config_list.dart';
import 'package:cyr/models/doctor/doctor_model.dart';
import 'package:cyr/models/model_list.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'pages/page_list.dart';
import 'package:flutter/services.dart';
import 'dart:io';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  final Doctor user;
  MyApp({@required this.user});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //设置Android状态栏透明
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => DoctorProvider(widget.user),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => PatientProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => MessageProvider(),
        ),
      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
          title: '卒中中心',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          home: widget.user == null ? LoginPage() : HomePage()),
    );
  }
}
