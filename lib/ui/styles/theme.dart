import 'package:flutter/material.dart';
import 'colorsIcons.dart';

ThemeData getTheme() {
  return ThemeData(
    primaryColor: MyColors.primary,
    primarySwatch: MyColors.primary,
    accentColor: MyColors.secondary,
    accentIconTheme: IconThemeData(
      color: MyColors.lightTextIcon,
    ),
    errorColor: MyColors.alertColor,
    scaffoldBackgroundColor: MyColors.background,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: MyColors.lightTextIcon),
      actionsIconTheme: IconThemeData(color: MyColors.lightTextIcon),
      elevation: 0,
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(foregroundColor: MyColors.lightTextIcon),
    textTheme: TextTheme(
      button: TextStyle(
        color: MyColors.lightTextIcon,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.25,
      ),
    ),
  );
}
