import 'package:flutter/material.dart';

import '../../../../../global/constants/Colors.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.child,
    this.width = 400,
     this.height = 400,
     this.margin,
     this.padding = 0,
     this.borderRadius = 400,
     this.backgroundColor,
  });
  final Widget? child;
  final EdgeInsetsGeometry? margin;

  final double width, height, padding, borderRadius;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ?? AppColor.textWhite.withOpacity(0.1),
      ),
      child: child,
    );
  }
}
