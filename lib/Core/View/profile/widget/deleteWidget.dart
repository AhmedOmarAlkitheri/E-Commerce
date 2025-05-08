// Delete Account Warning
import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/user/user.dart';
import 'package:ecommerce_app_client/Core/server/authController.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

UserVM userVM = Get.put(UserVM());
 final AuthController authController = Get.put(AuthController(useFirebase: false));
void deleteAccountWarningPopup() {
  Get.defaultDialog(
    contentPadding: EdgeInsets.all(SizesConstant.md),
    title: 'حذف حساب',
    middleText:
        'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
    confirm: ElevatedButton(
      onPressed: () async =>authController.deleteUser(),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red)),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizesConstant.lg),
          child: Text('حذف')),
    ),
    cancel: OutlinedButton(
      child: const Text('إلغاء'),
      onPressed: () => Navigator.of(Get.overlayContext!).pop(),
    ),
  );
}
