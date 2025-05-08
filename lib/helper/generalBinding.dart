import 'package:ecommerce_app_client/Core/ViewModel/address/addressVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/cartVM/cartVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/checkoutController.dart';
import 'package:ecommerce_app_client/Core/ViewModel/user/user.dart';
import 'package:ecommerce_app_client/Core/ViewModel/variationController.dart';
import 'package:ecommerce_app_client/Core/server/authController.dart';
import 'package:ecommerce_app_client/global/function/networkManager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(UserVM());
    Get.put(Authenticationvm());

        Get.put(VariationController());
                Get.put(CheckoutController());
              Get.put(AddressVM());
                   Get.put(CartVM());
   // Get.put(AuthController(useFirebase: true));
  }
}
