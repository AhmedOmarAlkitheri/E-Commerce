import 'package:ecommerce_app_client/Core/View/auth/login/login.dart';
import 'package:ecommerce_app_client/Core/View/onBoarding/controller/onBoardingController.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/function/deviceControl.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controllerOnBoarding = Get.put(OnBoardingController());
    return Obx(() => 
       Positioned(
        top: DeviceUtils.getAppBarHeight(),
        right: SizesConstant.defaultSpace,
        child: TextButton(
          onPressed: () {
            if (controllerOnBoarding.currentPageIndex.value == 2) {
               Get.offAllNamed("/Login");
            } else {
              OnBoardingController.instance.skipPage();
            }
          },
          child: controllerOnBoarding.currentPageIndex.value == 2
              ? Text('تسجيل الدخول')
              : Text('تخطي'),
        ), // TextButton
      ),
    ); // Positioned
  }
}
