import 'package:ecommerce_app_client/Core/View/auth/forgetPassword/ForgetPasswordScreen.dart';
import 'package:ecommerce_app_client/Core/View/auth/login/login.dart';
import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/constants/Strings.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  
  Authenticationvm authenticationvm = Get.put(Authenticationvm());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAllNamed("/Login"),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),
          child: Column(
            children: [
              // Image
              Image(
                image: AssetImage(ImagesConstant.Dominos),
                width: Helperfunction.screenWidth() * 0.6,
              ),
              SizedBox(height: SizesConstant.spaceBtwSection),
              // Title & SubTitle
              Text(
                StringConstant.resetPasswordSubTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizesConstant.spaceBtwItem),
              Text(
                StringConstant.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizesConstant.spaceBtwSection),
              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed("/Login");
                  },
                  child: Text("تم الارسال"),
                ),
              ),
              SizedBox(height: SizesConstant.spaceBtwItem),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                   authenticationvm
                       .sendPasswordResendEmailFirebase();
                    //  Get.offAllNamed("/ForgetPasswordScreen");
                  },
                  child: const Text(StringConstant.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
