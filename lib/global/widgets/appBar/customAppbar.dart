import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/deviceControl.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  Customappbar(
      {super.key,
      this.actions,
      this.title,
      this.onPressed,
      this.showBackArrow = false,
      this.leadingIcon});

  final List<Widget>? actions;
  final Widget? title;
  VoidCallback? leadingOnpressed , onPressed;
  final bool showBackArrow;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizesConstant.md),
      child: AppBar(
        title: title,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed:onPressed ,
                icon: Icon(
                  Icons.arrow_back,
                  color: dark ? AppColor.white : AppColor.black,
                ))
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnpressed, icon: Icon(leadingIcon))
                : null,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
