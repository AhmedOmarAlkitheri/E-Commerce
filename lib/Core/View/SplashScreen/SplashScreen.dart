import 'package:ecommerce_app_client/Core/View/SplashScreen/controller/splashController.dart';
import 'package:ecommerce_app_client/Core/View/auth/login/login.dart';
import 'package:ecommerce_app_client/Core/View/onBoarding/onBoardingScreen.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/helper/getstorage_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  Splashscreen({super.key});

  GetstorageHelper getstorageHelper = GetstorageHelper.instance;
  final splashControl = Get.put(splashController());

  @override
  Widget build(BuildContext context) {
    // print(getstorageHelper.readFromFile('token'));
    Future.delayed(Duration(seconds: 4), () {
      if (getstorageHelper.readFromFile("StateInstall") ?? true) {
        Get.offAllNamed("/OnboardingScreen");
      } else {
        if (getstorageHelper.readFromFile("currentUserId") == null) {
          Get.offAllNamed("/Login");
        } else {
          GetstorageHelper.init(getstorageHelper.readFromFile("currentUserId"));
          Get.offAllNamed("/Navigationmenu");
        }
      }
    });

    return Scaffold(
      body: Obx(
        () => Center(
          child: AnimatedOpacity(
            opacity: splashControl.opacity.value,
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            child: Image.asset(
              ImagesConstant.logo,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
