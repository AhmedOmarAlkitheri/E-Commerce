import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/deviceControl.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';

class customSearch extends StatelessWidget {
   const customSearch({
    super.key,
    required this.title,
    this.showColor = true,
    this.showBorder = true,
    required this.onTap, 
     this.padding ,
  });
  final String title;
  final bool showColor, showBorder;
  final VoidCallback onTap;
  final EdgeInsetsGeometry?padding;
  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:padding ??   EdgeInsets.symmetric(horizontal: SizesConstant.defaultSpace) ,
        child: Container(
          width: DeviceUtils.getScreenWidth(context),
          padding: EdgeInsets.all(SizesConstant.md),
          decoration: BoxDecoration(
            border: showBorder ? Border.all(color: AppColor.grey) : null,
            borderRadius: BorderRadius.circular(SizesConstant.cardRadiusLg),
            color: showColor
                ? dark
                    ? AppColor.dark
                    : AppColor.white
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Image.asset("${ImagesConstant.search}" , height: SizesConstant.iconMd, color: AppColor.darkGrey, ),
              
              SizedBox(
                width: SizesConstant.spaceBtwItem,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
