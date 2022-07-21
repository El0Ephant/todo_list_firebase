import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

abstract class TodoTheme {
  static final theme = ThemeData(
    primaryColor: mainColor,
    backgroundColor: darkColor,
    scaffoldBackgroundColor: darkColor,
    cardColor: backColor,

    textTheme: TextTheme(
      headline1: TextStyle(color: mainColor, fontSize: 17.sp, fontFamily: 'Rubik'),
      bodyText1: TextStyle(
          fontSize: 15.sp, fontFamily: 'Manrope', color: lightColor),
      bodyText2: TextStyle(
          fontSize: 13.sp, fontFamily: 'Manrope', color: lightColor),
    ),
    //fontFamily: 'Rubik',

  );

  static const darkColor = Colors.black;
  static const backColor = Color.fromRGBO(41, 44, 46, 1);
  static const mainColor = Color.fromRGBO(140, 90, 160, 1);
  static const subColor = Color.fromRGBO(15, 170, 220, 1);
  static const lightColor = Colors.white;
  static const extremeColor = Colors.redAccent;
}