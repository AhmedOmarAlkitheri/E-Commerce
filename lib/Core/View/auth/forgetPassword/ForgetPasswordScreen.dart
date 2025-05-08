import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/Core/server/authController.dart';

import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/constants/Strings.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/Colors.dart';
import '../../../../global/validation/validation.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController authController =
      Get.put(AuthController(useFirebase: true));
  Authenticationvm authenticationController = Get.put(Authenticationvm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(
        showBackArrow: true,
        onPressed: () => Get.offAllNamed("/Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizesConstant.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(
              StringConstant.forgotPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: SizesConstant.spaceBtwItem),
            Text(
              StringConstant.forgotPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: SizesConstant.spaceBtwSection * 2),
            // Text field
            Form(
              key: formKey,
              child: TextFormField(
                validator: (p0) => InputValidator.validateEmail(p0),
                controller: authenticationController.sendEmailController,
                decoration: InputDecoration(
                  labelText: StringConstant.email,
                  prefixIcon: Transform.scale(
                      scale: 0.5,
                      child: Image.asset(
                        ImagesConstant.mail,
                        color: AppColor.greyIcon,
                        height: SizesConstant.iconSm,
                      )),
                ),
              ),
            ),
            SizedBox(height: SizesConstant.spaceBtwSection),
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // authenticationController.sendPasswordResendEmailFirebase();
                    //  authenticationController   .resetPassword(     );

                    authController.sendEmailVerification();
                    //   .then((x) {
                    // if (x == "success") {
                    //   Get.snackbar("تم بنجاح",
                    //       'تم ارسال طلب تغيير كلمة السر الى بريدك هذا  ${authenticationController.emailController.text}');
                    //   Get.offAllNamed("/ResetPassword");
                    // } else {
                    //   Get.snackbar("خطاء", x.toString());
                    // }
                    //   });
                  }
                },
                child: const Text("إرسال"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
