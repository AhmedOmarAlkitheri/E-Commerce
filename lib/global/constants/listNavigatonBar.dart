import 'package:ecommerce_app_client/Core/View/favorite/favouriteScreen.dart';
import 'package:ecommerce_app_client/Core/View/homeScreen/homeScreen.dart';
import 'package:ecommerce_app_client/Core/View/setting/settingScreen.dart';
import 'package:ecommerce_app_client/Core/View/store/storeScreen.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';

final List<Widget> listItems = [
  Image.asset(
    ImagesConstant.home_agreement,
    height: SizesConstant.iconLg,
    // color: Helperfunction.isDarkMode(context)   ? AppColor.white  : AppColor.warning,
  ),
  Image.asset(
    ImagesConstant.supermarket,
    height: SizesConstant.iconLg,
  ),
  Image.asset(
    ImagesConstant.heart,
    height: SizesConstant.iconLg,
  ),
  Image.asset(
    ImagesConstant.user,
    height: SizesConstant.iconLg,
    // color: ,
  ),
];

final dynamic ScreensNavigation = [
  Homescreen(),
  StoreScreen(),
  FavouriteScreen(),
  SettingsScreen(),
];
