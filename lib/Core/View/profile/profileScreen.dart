import 'package:ecommerce_app_client/Core/View/auth/changeNamed/changeNamed.dart';
import 'package:ecommerce_app_client/Core/View/profile/widget/deleteWidget.dart';
import 'package:ecommerce_app_client/Core/View/profile/widget/profileMenu.dart';
import 'package:ecommerce_app_client/Core/View/setting/settingScreen.dart';
import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/images/circularImage.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ViewModel/user/user.dart';
import '../../server/authController.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
//  Authenticationvm authenticationvm = Get.put(Authenticationvm());
  final AuthController authController =
      Get.put(AuthController(useFirebase: false));
  final userVM = UserVM.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(
          showBackArrow: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAllNamed("/Navigationmenu");
                },
                icon: Icon(Icons.arrow_forward_ios_rounded))
          ],
          title: Text('الملف الشخصي')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() {
                        final networkImage =
                            userVM.userModel.value.profilePicture;
                        final image = networkImage!.isNotEmpty
                            ? networkImage
                            : ImagesConstant.man;

                        return userVM.loadingProfile.value 

                        ?


  ShimmerEffect(width: 80, height: 80 ,radius: 80,)

                        :
                        
                        
                         circularImage(
                            imageUrl: image, width: 80, height: 80  , isNetworkImage: networkImage.isNotEmpty ,);
                      }),
                      TextButton(
                          onPressed: () => userVM.uploadUserProfilePictureSupabase(),
                          child: const Text('تغيير صورة الملف الشخصي')),
                    ],
                  ),
                ),
                SizedBox(height: SizesConstant.spaceBtwItem / 2),
                const Divider(),
                SizedBox(height: SizesConstant.spaceBtwItem),
                // Heading Profile Info
                const SectionHeading(
                    title: 'معلومات الملف الشخصي', showActionButton: false),
                SizedBox(height: SizesConstant.spaceBtwItem),

                ProfileMenu(
                    title: 'أسم المستخدم',
                    value: userVM.userModel.value.user_name!,
                    onPressed: () {
                      Get.toNamed("/ChangeName");
                    }),

                // ProfileMenu(
                //     title: 'أسم المستخدم', value: 'coding_with_t', onPressed: () {

                //     }),

                SizedBox(height: SizesConstant.spaceBtwItem),
                const Divider(),
                SizedBox(height: SizesConstant.spaceBtwItem),

                // Heading Personal Info
                const SectionHeading(
                    title: 'المعلومات الشخصية', showActionButton: false),
                SizedBox(height: SizesConstant.spaceBtwItem),

                // ProfileMenu(
                //     title: 'User ID',
                //     value: '45689',
                //     icon: Icons.copy_rounded,
                //     onPressed: () {}),
                ProfileMenu(
                    title: 'البريد الألكتروني',
                    value: userVM.userModel.value.email!,
                    onPressed: () {}),
                ProfileMenu(
                    title: 'رقم الجوال',
                    value: userVM.userModel.value.phoneNumber!,
                    onPressed: () {}),
                ProfileMenu(title: 'الجنس', value: 'ذكر', onPressed: () {}),
                // ProfileMenu(
                //     title: 'Date of Birth',
                //     value: '10 Oct, 1994',
                //     onPressed: () {}),

                const Divider(),
                SizedBox(height: SizesConstant.spaceBtwItem),

                Center(
                  child: TextButton(
                    onPressed: () {
                      // Get.offAllNamed("/SettingsScreen");
                      deleteAccountWarningPopup();
                    },
                    child: const Text('حذف حسابك',
                        style: TextStyle(color: Colors.red)),
                  ), // TextButton
                ), // Center
              ],
            ),
          ),
        ),
      ),
    );
  }
}
