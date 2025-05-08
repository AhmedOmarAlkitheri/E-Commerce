import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../server/authController.dart';

class ReAuthLoginForm extends StatelessWidget {
  ReAuthLoginForm({super.key});

  GlobalKey<FormState> reAuthformKey = GlobalKey<FormState>();
  final controller = Get.put(Authenticationvm());
  final AuthController authController =
      Get.put(AuthController(useFirebase: false));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Re-authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),
          child: Form(
            key: reAuthformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: (value) => InputValidator.validateEmail(value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, size: 20),
                    labelText: "البريد الألكتروني",
                  ),
                ),
                SizedBox(height: SizesConstant.spaceBtwInputField),
                // Password
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) =>
                        InputValidator.validatePassword(value),
                    decoration: InputDecoration(
                      labelText: "كلمة المرور",
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        icon: Icon(controller.hidePassword.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizesConstant.spaceBtwSection),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (reAuthformKey.currentState!.validate()) {
                        await authController.validateCredentials();
                      }
                    },
                    child: const Text('Verify'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
