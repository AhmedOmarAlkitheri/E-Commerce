
import 'package:ecommerce_app_client/Core/View/homeScreen/Widget/headerScreen/CircularContainer.dart';
import 'package:ecommerce_app_client/Core/View/homeScreen/Widget/headerScreen/customCurved.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:flutter/material.dart';

class curvedHeader extends StatelessWidget {
  const curvedHeader({
    super.key, required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: Customcurved(),
      child: Container(
        padding: EdgeInsets.all(0),
        color: AppColor.primary,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CircularContainer(),
            ),
            child ,
          ],
        ),
      ),
    );
  }
}
