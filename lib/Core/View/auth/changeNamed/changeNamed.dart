import 'package:ecommerce_app_client/Core/View/profile/widget/deleteWidget.dart';
import 'package:ecommerce_app_client/Core/server/authController.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/validation/validation.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ViewModel/user/user.dart';

class ChangeName extends StatelessWidget {
  ChangeName({super.key});
  TextEditingController fullName1 = TextEditingController();

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();
  final AuthController authController =
      Get.put(AuthController(useFirebase: false));
  final UserVM controller = Get.put(UserVM());
  @override
  Widget build(BuildContext context) {
    fullName1.text = "احمد";

    return Scaffold(
      /// Custom Appbar
      appBar: Customappbar(
        showBackArrow: true,
        onPressed: () => Get.toNamed("/ProfileScreen"),
        title: Text('تغيير أسمك',
            style: Theme.of(context).textTheme.headlineSmall),
      ), // TAppBar
      body: Padding(
        padding: EdgeInsets.all(SizesConstant.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ), // Text
            SizedBox(height: SizesConstant.spaceBtwSection),

            Form(
              key: updateUserNameFormKey,
              child:

                  // Column(
                  //   children: [

                  TextFormField(
                controller: controller.fullName,
                validator: (value) => InputValidator.validateArabicName(value),
                expands: false,
                decoration: const InputDecoration(
                  labelText: "الاسم",
                  prefixIcon: Icon(Icons.person),
                ),
              ), // TextFormField
              //  SizedBox(height: SizesConstant.spaceBtwInputField),
              // TextFormField(
              //   controller: controller.lastName,
              //   // validator: (value) => TValidator.validateEmptyText('Last name', value),
              //   expands: false,
              //   decoration: const InputDecoration(
              //     labelText: TTexts.lastName,
              //     prefixIcon: Icon(Icons.person),
              //   ),
              // ), // TextFormField
              //  ],
            ), // Column,Form

            SizedBox(height: SizesConstant.spaceBtwSection),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (updateUserNameFormKey.currentState!.validate()) {
                    authController.updateUserNameProfile();
                  }
                },
                child: const Text('حفظ'),
              ),
            ), // SizedBox
          ],
        ),
      ),
    );
  }
}
