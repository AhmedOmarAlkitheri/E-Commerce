import 'package:ecommerce_app_client/Core/ViewModel/favouritesController.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/widgets/circularIcon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FavouriteIcon extends StatelessWidget {
    const FavouriteIcon({
        super.key,
        required this.productId,
    });

    final String productId;

    @override
    Widget build(BuildContext context) {
        final controller = Get.put(FavouritesController());
        return Obx(
            () => CircularIcon(
                icon: controller.isFavorite(productId) ? "${ImagesConstant.heart}" : "${ImagesConstant.heart}" ,
                color: controller.isFavorite(productId) ? AppColor.error : null,
                onPressed: () => controller.toggleFavoriteProduct(productId),
            ), // TCircularIcon
        ); // Obx
    }
}