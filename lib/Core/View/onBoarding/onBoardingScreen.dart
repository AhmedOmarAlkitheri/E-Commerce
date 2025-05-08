import 'package:ecommerce_app_client/Core/View/onBoarding/controller/onBoardingController.dart';
import 'package:ecommerce_app_client/Core/View/onBoarding/widget/onBoardingDotNavigation.dart';
import 'package:ecommerce_app_client/Core/View/onBoarding/widget/onBoardingPage.dart';
import 'package:ecommerce_app_client/Core/View/onBoarding/widget/onBoardingSkip.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/deviceControl.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  int? index;
  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    final controllerOnBoarding = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controllerOnBoarding.pageController,
            onPageChanged: controllerOnBoarding.updatePageIndicator,
            reverse: true,
            children: [
              OnBoardingPage(
                isNetWorkImage: true,
                image:"https://i.postimg.cc/mhhVywp9/splash-1.png" ,
            //   ImagesConstant.Dominos,
                title: "أختر منتجك",
                subTitle:
                    "مرحبا بك في عالم من الخيارات غير المحدودة - منتجك في أنتظارك",
              ),
              OnBoardingPage(
                    isNetWorkImage: true,
                image: "https://i.postimg.cc/PNcy3w0R/splash-2.png",
                title: "1أختر منتجك",
                subTitle:
                    "مرحبا بك في عالم من الخيارات غير المحدودة - منتجك في أنتظارك",
              ),
              OnBoardingPage(
                    isNetWorkImage: true,
                image:  "https://i.postimg.cc/wRtVxqR2/splash-3.png",
                title: "2أختر منتجك",
                subTitle:
                    "مرحبا بك في عالم من الخيارات غير المحدودة - منتجك في أنتظارك",
              ),
            ],
          ),
          OnBoardingDotNavigation(),
          OnBoardingSkip(),
          Obx(
            () => Positioned(
              right: SizesConstant.defaultSpace,
              bottom: DeviceUtils.getBottomNavigationBarHeight(),
              child: ElevatedButton(
                onPressed: () {
                  // index = controllerOnBoarding.currentPageIndex.value;
                  if (controllerOnBoarding.currentPageIndex.value == 2) {
                    Get.offAllNamed("/Createaccount");
                  } else {
                    OnBoardingController.instance.nextPage();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(
                    SizesConstant.md,
                  ),
                  shape: controllerOnBoarding.currentPageIndex.value == 2
                      ? null
                      : CircleBorder(),
                  backgroundColor: dark ? AppColor.primary : AppColor.primary,
                ),
                child: controllerOnBoarding.currentPageIndex.value == 2
                    ? Text(
                        "إنشاء حساب",
                        style: TextStyle(color: AppColor.white),
                      )
                    : Icon(Icons.arrow_back_ios_rounded),
              ), // ElevatedButton
            ),
          ),
        ],
      ),
    );
  }
}
