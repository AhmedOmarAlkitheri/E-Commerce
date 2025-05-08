import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    Key? key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  }) : super(key: key);

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    return Shimmer.fromColors(
    

      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? AppColor.darkerGrey : AppColor.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

