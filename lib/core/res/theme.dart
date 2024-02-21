import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/core/res/fonts.dart';

class AppTheme {
  AppTheme._();
  static final currentTheme = ThemeData(
    colorSchemeSeed: Colours.primaryColor,
    scaffoldBackgroundColor: Colours.backgroundColor,
    brightness: Brightness.dark,
    textTheme: AppFonts.textTheme,
    fontFamily: AppConstant.font,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colours.primaryColor,
        foregroundColor: Colours.backgroundColor,
        minimumSize: const Size.fromHeight(Sizes.p56),
        shadowColor: Colors.black12,
        elevation: 0,
        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16).r,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colours.backgroundColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: const IconThemeData(
          color: Colours.primaryColor,
        ),),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: REdgeInsets.symmetric(vertical: 10, horizontal: 8),
      ),
    ),
  );
}
