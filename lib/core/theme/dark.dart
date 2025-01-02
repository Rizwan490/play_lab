import 'package:flutter/material.dart';
import '../utils/my_color.dart';

ThemeData dark = ThemeData(
  useMaterial3: true,
  fontFamily: 'Mulish',
  primaryColor: MyColor.primaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF2C2C2C),
  hintColor: MyColor.gbr,
  focusColor: MyColor.gbr,
  bottomAppBarTheme: const BottomAppBarTheme(color: MyColor.cardBg),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: MyColor.secondaryColor,
    selectedItemColor: MyColor.primaryColor,
    unselectedItemColor: MyColor.primaryText,
    type: BottomNavigationBarType.fixed,
  ),
);
