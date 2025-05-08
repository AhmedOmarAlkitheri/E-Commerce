
import 'package:ecommerce_app_client/global/theme/custom_theme/appBar_theme.dart';
import 'package:ecommerce_app_client/global/theme/custom_theme/buttomSheet_theme.dart';
import 'package:ecommerce_app_client/global/theme/custom_theme/checkBox_theme.dart';
import 'package:ecommerce_app_client/global/theme/custom_theme/chip_theme.dart';
import 'package:ecommerce_app_client/global/theme/custom_theme/elevatedButton_theme.dart';
import 'package:ecommerce_app_client/global/theme/custom_theme/outLinedButton_theme.dart';
import 'package:ecommerce_app_client/global/theme/custom_theme/textFormField_theme.dart';
import 'package:ecommerce_app_client/global/theme/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';



class StoreAppTheme {
  StoreAppTheme._();

  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Tajawal',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: StoreTextTheme.lightTextTheme,
    chipTheme: StoreChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: StoreAppBarTheme.LightAppBarTheme,
    checkboxTheme: StoreCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: StoreBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: StoreElevatedButtonTheme.LightElevatedButtonThemeData,
    outlinedButtonTheme: StoreOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: StoreTextFormFieldTheme.lightInputDecorationTheme,
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Tajawal',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: StoreTextTheme.darkTextTheme,
    chipTheme: StoreChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: StoreAppBarTheme.darkAppBarTheme,
    checkboxTheme: StoreCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: StoreBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: StoreElevatedButtonTheme.darkElevatedButtonThemeData,
    outlinedButtonTheme: StoreOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: StoreTextFormFieldTheme.darkInputDecorationTheme,
  );
}