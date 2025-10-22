import 'package:charm/global/colors.dart';
import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  scaffoldBackgroundColor: colorWhite,
  textTheme: TextTheme(
    headlineLarge: textStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
    bodyMedium: textStyle,
  ),
  buttonTheme: ButtonThemeData(buttonColor: colorPrimary, disabledColor: colorSoftGrey),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: colorPrimary,
      foregroundColor: colorWhite,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: colorPrimary,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey),
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colorPrimary, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colorPrimary, width: 2),
    ),
  ),
  dialogTheme: DialogThemeData(backgroundColor: colorWhite),
  dividerColor: colorGrey,
);

TextStyle textStyle = TextStyle(color: colorBlack, fontSize: 14);
