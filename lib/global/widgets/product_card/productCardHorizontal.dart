import 'package:ecommerce_app_client/Core/Model/productModel.dart';

import 'package:ecommerce_app_client/Core/ViewModel/productVM/productVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/constants/enum.dart';

import 'package:ecommerce_app_client/global/function/helperFunction.dart';

import 'package:ecommerce_app_client/global/widgets/images/roundedImage.dart';
import 'package:ecommerce_app_client/global/widgets/product_card/productCardAddToCartButton/productCardAddToCartButton.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:ecommerce_app_client/global/widgets/style/shadowStyle.dart';
import 'package:ecommerce_app_client/global/widgets/text/productPriceText.dart';
import 'package:ecommerce_app_client/global/widgets/text/productTitleText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/View/favorite/favouriteIcon.dart';

class ProductCardHorizontal extends StatelessWidget {
  ProductCardHorizontal({super.key, required this.product});
  ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    final controller = Productvm.instance;
    final salepercentage =
        controller.calculateSalePercentage(product.price!, product.salePrice);
    return GestureDetector(
      onTap: () {
        Get.toNamed("/ProductDetailScreen", arguments: product);
      },
      child: Container(
          width: 320,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            boxShadow: [ShadowStyle.verticalProductShadow],
            borderRadius:
                BorderRadius.circular(SizesConstant.productImageRadius),
            color: dark ? AppColor.darkerGrey : AppColor.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizesConstant.sm, top: SizesConstant.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: SizesConstant.sm),
                              child: ProductTitleText(
                                  title: product.title!, smallSize: true)),
                          SizedBox(height: SizesConstant.spaceBtwItem),
                          Container(
                            margin: EdgeInsets.only(right: SizesConstant.sm),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImagesConstant.success,
                                  height: SizesConstant.iconXs,
                                ),
                                SizedBox(width: SizesConstant.xs),
                                Text(
                                  product.brand!.brandName ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    //SizedBox(height: SizesConstant.spaceBtwItem / 3),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //  if (product.productType == ProductType.single.toString() && product.salePrice > 0)
                        ProductCardAddToCartButton(product: product),
                        Flexible(
                          child: Column(
                            children: [
                              if (product.productType ==
                                      ProductType.single.toString() &&
                                  product.salePrice! > 0)
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: SizesConstant.sm),
                                  child: Text(
                                    product.price.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .apply(
                                            decoration:
                                                TextDecoration.lineThrough),
                                  ),
                                ),

                              // Price, Show sale price as main price if sale exist.
                              Padding(
                                padding:
                                    EdgeInsets.only(left: SizesConstant.sm),
                                child: ProductPriceText(
                                    price: controller.getProductPrice(product)),
                              ), // Padding
                            ],
                          ), // Column
                        ),
                        // Padding(
                        //     padding: EdgeInsets.only(
                        //       left: SizesConstant.sm,
                        //     ),
                        //     child: ProductPriceText(price: product.price.toString(),)),
                      ],
                    ),
                  ],
                ),
              ),
              RoundedContainer(
                height: 180,
                backgroundColor: Colors.transparent,
                width: 150,
                child: Stack(children: [
                  RoundedImage(
                      isNetworkImage: true,
                      imageUrl: product.thumbnail!,
                      applyImageRadius: true,
                      height: 180),
                  if (salepercentage != null)
                    Positioned(
                      top: 12,
                      left: 5,
                      child: RoundedContainer(
                        radius: SizesConstant.sm,
                        backgroundColor: AppColor.secondary.withOpacity(0.8),
                        padding: EdgeInsets.symmetric(
                            horizontal: SizesConstant.sm,
                            vertical: SizesConstant.xs),
                        child: Text('$salepercentage%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: AppColor.black)),
                      ),
                    ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: FavouriteIcon(
                        productId: product.id!,
                      )),
                ]),
              ),
            ],
          )),
    );
  }
}
