
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:flutter/material.dart';

class ShadowStyle {
  static final BoxShadow verticalProductShadow = BoxShadow(
    color:AppColor.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2), // BoxShadow
  );

  static final BoxShadow horizontalProductShadow = BoxShadow(
    color:AppColor.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2), // BoxShadow
  );
}