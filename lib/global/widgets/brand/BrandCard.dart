import 'package:ecommerce_app_client/Core/Model/brandModel.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';

import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/constants/enum.dart';
import 'package:ecommerce_app_client/global/function/FirebaseStorageService.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/images/circularImage.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/verticalProductShimmer.dart';
import 'package:ecommerce_app_client/global/widgets/sortableProduct.dart';
import 'package:ecommerce_app_client/global/widgets/text/brandTitleWithVerifiedIcon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandCard extends StatelessWidget {
  BrandCard({
  
    super.key,
    required this.showBorder,
    this.onTap,
    // this.imageUrl,
    // this.count,
    // this.title,
   required this.brand
  });
  final bool showBorder;
  // final String? imageUrl, count, title;
  final void Function()? onTap;
  BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offAllNamed("/BrandProducts" , arguments:  brand);
      },
      child:  RoundedContainer(
          backgroundColor: (Helperfunction.isDarkMode(context))
              ? Colors.transparent
              : AppColor.white,
          padding: EdgeInsets.all(SizesConstant.sm),
          showBorder: showBorder,
          child: Row(
            children: [
              Flexible(
                child: circularImage(
                  isNetworkImage: true,
                  imageUrl:brand.logoUrl ?? ImagesConstant.Dominos ,     // imageUrl ?? ImagesConstant.Dominos,
                  backgroundColor: Colors.transparent,
                  overlayColor: (Helperfunction.isDarkMode(context))
                      ? AppColor.white
                      : AppColor.black,
                ),
              ),
              SizedBox(height: SizesConstant.spaceBtwItem / 2),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BrandTitleWithVerifiedIcon(
                      title: brand.brandName ?? "", // title ?? "",
                      brandTextSize: TextSizes.large,
                    ),
                    Text(
                      '${brand.productsCount } products',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}
