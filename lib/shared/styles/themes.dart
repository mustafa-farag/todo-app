import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'colors.dart';


ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  appBarTheme:const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ) ,
  textTheme:const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
  ),
  floatingActionButtonTheme:const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
    type:BottomNavigationBarType.fixed,
    elevation: 40.0,
    selectedItemColor: defaultColor,
  ),
);
ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('333739'),
    titleTextStyle:const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    elevation: 0.0,
    iconTheme:const IconThemeData(
      color: Colors.white,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ) ,
  floatingActionButtonTheme:const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  textTheme:const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type:BottomNavigationBarType.fixed,
    backgroundColor: HexColor('333739'),
    elevation: 40.0,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
);