import 'package:ecommerce_app_client/Core/View/SplashScreen/SplashScreen.dart';
import 'package:ecommerce_app_client/Core/View/address/userAddressScreen.dart';
import 'package:ecommerce_app_client/Core/View/auth/login/login.dart';
import 'package:ecommerce_app_client/Core/View/homeScreen/Widget/headerScreen/curvedHeader.dart';
import 'package:ecommerce_app_client/Core/View/order/orderScreen.dart';
import 'package:ecommerce_app_client/Core/View/setting/widget/settingsMenuTile.dart';
import 'package:ecommerce_app_client/Core/View/setting/widget/userProfileTile.dart';
import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/setting/settingVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/getstorage_helper.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
   GetstorageHelper getstorageHelper = GetstorageHelper.instance;
  Authenticationvm authenticationvm = Get.put(Authenticationvm());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            curvedHeader(
              child: Column(
                children: [
                  /// AppBar
                  Customappbar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: AppColor.white),
                    ),
                  ),

                  /// User Profile Card
                 UserProfileTile(),
                  SizedBox(height: SizesConstant.spaceBtwSection),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: EdgeInsets.all(SizesConstant.defaultSpace),
              child: Column(
                children: [
                  /// Account Settings
                  SectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  SizedBox(height: SizesConstant.spaceBtwItem),

                  SettingsMenuTile(
                    icon: "${ImagesConstant.location}",
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery address',
                    onTap: () {
                      Get.offAllNamed("/UserAddressScreen");
                    },
                  ),
                  SettingsMenuTile(
                      icon: "${ImagesConstant.shoppingCart}",
                      title: 'My Cart',
                      subtitle: 'Add, remove products and move to checkout'),
                  SettingsMenuTile(
                    icon: "${ImagesConstant.checkout}",
                    title: 'My Order',
                    subtitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.offAllNamed("/OrderScreen"),
                  ),
                  //  SettingsMenuTile(
                  //     icon: Icons.image,
                  //     title: 'Bank Account',
                  //     subtitle: 'Withdraw balance to registered bank account'),
                  SettingsMenuTile(
                      icon: "${ImagesConstant.logo}",
                      title: 'My Coupons',
                      subtitle: 'List of all the discounted coupons'),
                  SettingsMenuTile(
                      icon: "${ImagesConstant.notification}",
                      title: 'Notifications',
                      subtitle: 'Set any kind of notification message'),
                  // const SettingsMenuTile(
                  //     icon: Icons.image,
                  //     title: 'Account Privacy',
                  //     subtitle: 'Manage data usage and connected accounts'),

// App Settings
                  SizedBox(height: SizesConstant.spaceBtwSection),
                  SectionHeading(
                      title: 'App Settings', showActionButton: false),
                  SizedBox(height: SizesConstant.spaceBtwItem),
                  // SettingsMenuTile(
                  //     icon: Icons.image,
                  //     title: 'Load Data',
                  //     subtitle: 'Upload Data to your Cloud Firebase'),
                  // SettingsMenuTile(
                  //   icon: Icons.image,
                  //   title: 'Geolocation',
                  //   subtitle: 'Set recommendation based on location',
                  //   trailing: Switch(value: true, onChanged: (value) {}),
                  // ),
                  SettingsMenuTile(
                    icon: "${ImagesConstant.darkMode}",
                    title: 'Safe Mode',
                    subtitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  // SettingsMenuTile(
                  //   icon: Icons.image,
                  //   title: 'HD Image Quality',
                  //   subtitle: 'Set image quality to be seen',
                  //   trailing: Switch(value: false, onChanged: (value) {}),
                  // ),

// Logout Button
                  SizedBox(height: SizesConstant.spaceBtwSection),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {
                           
                          authenticationvm.signout();

                       
                        
                           
                        },
                         
                       
                        child: const Text('تسجيل خروج')),
                  ),
                  SizedBox(height: (SizesConstant.spaceBtwSection * 2.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
