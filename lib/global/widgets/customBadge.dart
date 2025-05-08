import 'package:ecommerce_app_client/Core/ViewModel/cartVM/cartVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Badge customBadge({

  IconData? icon,
  VoidCallback? onPressed,
  required BuildContext context,
  Color? color,
}) {
  final dark = Helperfunction.isDarkMode(context);
  final controllCart = CartVM.instance;
  return Badge(
    offset: Offset(27, 6),
    label: Obx(() =>
    Text("${
         controllCart.noOfCartItems.value}"),
   ) ,
    child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(
          ImagesConstant.shoppingCart_1,
          height: 25,
          color: color ?? (dark ? AppColor.light : AppColor.dark),
        )),
  );
}
