import 'package:flutter/material.dart';

// 浅色主题
ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.indigo,
    primaryColor: Colors.indigo,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.white, fontSize: 18,  letterSpacing: 2)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 2,
        selectedIconTheme: IconThemeData(
            size: 24,
            color: Colors.indigo
        ),
        unselectedIconTheme: IconThemeData(
            size: 24,
            color: Colors.grey
        ),
        selectedLabelStyle: TextStyle(
            color: Colors.indigo,
            fontSize: 12.0,
            fontWeight: FontWeight.w600
        ),
        unselectedLabelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12.0
        )
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      brightness: Brightness.dark,
      color: Colors.indigo,
      elevation: 0,
    ),
    iconTheme: IconThemeData(
      size: 24.0,
    ),
    shadowColor: Colors.indigo[50],
  accentColor: Colors.indigo[100],
);

