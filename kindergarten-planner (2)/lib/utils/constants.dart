import 'package:flutter/material.dart';

// 日期范围常量
final DateTime kFirstDay = DateTime(DateTime.now().year, 1, 1);
final DateTime kLastDay = DateTime(DateTime.now().year + 1, 12, 31);

// 角色常量
const roleAdmin = 'admin';
const roleTeacher = 'teacher';

// 应用主题
final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Inter',
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  cardTheme: const CardTheme(
    elevation: 2,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
);
