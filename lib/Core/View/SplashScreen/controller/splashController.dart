import 'package:get/get.dart';

class splashController  extends GetxController  {

Rx<double> opacity = 0.0.obs;

@override
  void onInit() {
   Future.delayed(Duration(microseconds: 100 , ) , () =>  opacity.value = 1.0 ,);

    // Future.delayed(Duration(seconds: 3), () {
    //      Get.offAllNamed("/OnboardingScreen");
         
    // });
    super.onInit();
  }

}