import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app_client/Core/View/favorite/favouriteIcon.dart';
import 'package:ecommerce_app_client/Core/ViewModel/imagesController.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/CircularIcon.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/curvedEdgeWidget.dart';
import 'package:ecommerce_app_client/global/widgets/images/roundedImage.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/productModel.dart';

class ProductImageSlider extends StatelessWidget {
   ProductImageSlider({
    super.key, required this.product 
  });
  ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
      final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    return 
    
    CurvedEdgeWidget( 
        child: Container(
            color: dark ? AppColor.darkerGrey : AppColor.light,
            child: Stack(
                children: [
                    // Main Large Image
                    SizedBox(
                        height: 400,
                        child: Padding(
                            padding:  EdgeInsets.all(SizesConstant.productImageRadius * 2),
                            child: Center(child: Obx(() {
                                final image = controller.selectedProductImage.value;
                                return GestureDetector(
                                    onTap: () => controller.showEnlargedImage(image),
                                    child: CachedNetworkImage(
                                        imageUrl: image,
                                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                                            CircularProgressIndicator(value: downloadProgress.progress, color: AppColor.primary),
                                    ), // CachedNetworkImage
                                ); // GestureDetector
                            })), // Obx, Center
                        ), // Padding
                    ), // SizedBox
/// Image Silder
Positioned(
    right: 0,
    bottom: 30,
    left: SizesConstant.defaultSpace,
    child: SizedBox(
        height: 80,
        child: ListView.separated(
            itemCount: images.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (_, __) =>  SizedBox(width: SizesConstant.spaceBtwItem),
            itemBuilder: (_, index) => Obx(() {
                final imageSelected = controller.selectedProductImage.value == images[index];
                return RoundedImage(
                    width: 80,
                    isNetworkImage: true,
                    imageUrl: images[index],
                    padding:  EdgeInsets.all(SizesConstant.sm),
                    backgroundColor: dark ? AppColor.dark : AppColor.white,
                    onPressed: () => controller.selectedProductImage.value = images[index],
                    border: Border.all(color: imageSelected ? AppColor.primary : Colors.transparent),
                ); // TRoundedImage
            }),
        ), // ListView.separated
    ), // SizedBox
), // Positioned
         

            /// Appbar Icons
            Customappbar(
              showBackArrow: true,
              onPressed: ()=> Get.offAllNamed("/Navigationmenu"),
              actions: [
              FavouriteIcon(productId: product.id!,)
              ],
            ), // TAppBar
          ],
        ), // Stack
      ), // Container
    ); // TCurvedEdgesWidget
  }
}



   // /// Image Slider
            // Positioned(
            //   right: 0,
            //   bottom: 30,
            //   left: SizesConstant.defaultSpace,
            //   child: SizedBox(
            //     height: 80,
            //     child: ListView.separated(
            //       itemCount: 4,
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       physics: const AlwaysScrollableScrollPhysics(),
            //       separatorBuilder: (_, __) =>
            //           SizedBox(width: SizesConstant.spaceBtwItem),
            //       itemBuilder: (_, index) => RoundedImage(
            //         width: 80,
            //         backgroundColor: dark ? AppColor.dark : AppColor.white,
            //         border: Border.all(color: AppColor.primary),
            //         padding: EdgeInsets.all(SizesConstant.sm),
            //         imageUrl: ImagesConstant.OuP5,
            //       ), // TRoundedImage
            //     ), // ListView.separated
            //   ), // SizedBox
            // ), // Positioned