import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/function/deviceControl.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required this.tab,
  });

  final List<Widget> tab;

  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    return 
     Material(
        color: dark ? AppColor.black : AppColor.white,
        child: TabBar(
          tabs: tab,
          isScrollable: true,
          indicatorColor: AppColor.primary,
          unselectedLabelColor: AppColor.darkGrey,
          labelColor: dark ? AppColor.white : AppColor.primary,
        ),
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
