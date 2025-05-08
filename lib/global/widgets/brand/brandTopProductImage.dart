


  import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:flutter/material.dart';

  Widget brandTopProductImage(String image, BuildContext context) {
    return Expanded(
        child: RoundedContainer(
            height: 100,
            padding:  EdgeInsets.all(SizesConstant.md),
            margin:  EdgeInsets.only(right: SizesConstant.sm),
            backgroundColor: Helperfunction.isDarkMode(context) ? AppColor.darkerGrey : AppColor.light,
            child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: image,
                progressIndicatorBuilder: (context, url, downloadProgress) => const ShimmerEffect(width: 100, height: 100),
                errorWidget: (context, url, error) => const Icon(Icons.error),
            ), // CachedNetworkImage
        ), // TRoundedContainer
    ); // Expanded
}


