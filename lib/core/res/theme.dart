import 'package:flutter/material.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/core/res/fonts.dart';

class AppTheme {
  AppTheme._();
  static final currentTheme = ThemeData(
    colorSchemeSeed: Colours.primaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colours.backgroundColor,
    textTheme: AppFonts.textTheme,
    fontFamily: 'Roboto',
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
