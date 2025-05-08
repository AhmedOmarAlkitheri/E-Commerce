
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
   const CircularIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.size,
    this.color,
    this.onPressed,
    this.backgroundColor,
  });

  final double? width, height, size;
  final String icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? (Helperfunction .isDarkMode(context)
            ?AppColor.black.withOpacity(0.9)
            :AppColor.white.withOpacity(0.9)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon:   
        Image.asset( icon ,  color: color, height: size ?? SizesConstant.lg),
        //  Icon(icon, color: color, size: size ?? SizesConstant.lg),
      ),
    );
  }
}

