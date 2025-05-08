import 'package:ecommerce_app_client/Core/View/auth/register/register.dart';
import 'package:ecommerce_app_client/Core/View/auth/login/login.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update Current Index when Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to the specific dot selected page.
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  // Update Current Index & jump to next page
  void nextPage() {
 
      Get.offAllNamed("/Createaccount");
   
    int page =   currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    
  }

  // Update Current Index & jump to the last Page
  void skipPage() {
    
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
