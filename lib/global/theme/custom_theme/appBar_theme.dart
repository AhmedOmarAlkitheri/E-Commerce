import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:flutter/material.dart';

class StoreAppBarTheme {
  StoreAppBarTheme._();
  static final LightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600 , color: AppColor.black  ),
    actionsIconTheme: IconThemeData(color: AppColor.black , size: SizesConstant.iconMd),
  );

  static final darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600 , color: AppColor.white ),
    iconTheme: IconThemeData(color: AppColor.black,  size: SizesConstant.iconMd,
    ),
    actionsIconTheme: IconThemeData(color: AppColor.white,  size: SizesConstant.iconMd,
    ),
  );
}
