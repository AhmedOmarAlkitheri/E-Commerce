import 'package:ecommerce_app_client/Core/ViewModel/user/user.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/widgets/images/circularImage.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/Sizes.dart';

class UserProfileTile extends StatelessWidget {
  UserProfileTile({
    super.key,
  });

  UserVM userVM = Get.put(UserVM());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        leading:

            // circularImage(    imageUrl: ImagesConstant.man, width: 50, height: 50, padding: 0),
            Obx(() {
          final networkImage = userVM.userModel.value.profilePicture;
          final image =
              networkImage!.isNotEmpty ? networkImage : ImagesConstant.man;

          return userVM.loadingProfile.value
              ? ShimmerEffect(
                  width: 50,
                  height: 50,
                  radius: 50,
                )
              : circularImage(
                  imageUrl: image,
                  width: 50,
                  height: 50,
                  isNetworkImage: networkImage.isNotEmpty,
                  padding: 0,
                );
        }),
        title: Obx(() {
          return userVM.userModel.value.user_name == "" ||
                  userVM.userModel.value.user_name == null
              ? ShimmerEffect(
                  width: 88,
                  height: 30,
                  color: AppColor.black,
                )
              : Text(userVM.userModel.value.user_name!,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: AppColor.white));
        }),
        subtitle: Text(userVM.userModel.value.email!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: AppColor.white)),
        trailing: IconButton(
            onPressed: () {
              Get.offAllNamed("/ProfileScreen");
            },
            icon: Image.asset(
              ImagesConstant.edit,
              color: AppColor.white,
              height: SizesConstant.iconMenuSetting,
            )),
      ),
    );
  }
}
