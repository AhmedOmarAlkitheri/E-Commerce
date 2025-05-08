import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:flutter/material.dart';

class StoreChipTheme {
  StoreChipTheme._();
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: AppColor.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: AppColor.black),
    selectedColor: AppColor.primary,
    checkmarkColor: AppColor.white,
    //  secondaryLabelStyle: const TextStyle(color: Colors.blue),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: AppColor.grey,
    labelStyle: const TextStyle(color: AppColor.white),
    selectedColor: AppColor.primary,
    checkmarkColor: AppColor.white,
    //  secondaryLabelStyle: const TextStyle(color: Colors.blue),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
  );
}
