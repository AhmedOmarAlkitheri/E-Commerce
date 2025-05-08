import 'package:ecommerce_app_client/Core/View/onBoarding/controller/onBoardingController.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../global/function/deviceControl.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    final controllerOnBoarding = OnBoardingController.instance;
    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight() + 25,
      left: SizesConstant.defaultSpace,

      child: SmoothPageIndicator(
        textDirection: TextDirection.ltr,
        controller: controllerOnBoarding.pageController,
        onDotClicked: controllerOnBoarding.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(
            activeDotColor: dark ? AppColor.light : AppColor.dark,
            dotHeight: 6),
      ), // SmoothPageIndicator
    ); // Positioned
  }
}
