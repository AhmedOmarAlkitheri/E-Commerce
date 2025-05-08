import 'package:ecommerce_app_client/Core/Model/productModel.dart';
import 'package:ecommerce_app_client/Core/View/checkout/checkoutScreen.dart';
import 'package:ecommerce_app_client/Core/View/productDetailScreen/widget/bottomAddToCart.dart';
import 'package:ecommerce_app_client/Core/View/productDetailScreen/widget/productAttributes.dart';
import 'package:ecommerce_app_client/Core/View/productDetailScreen/widget/productImageSlider.dart';
import 'package:ecommerce_app_client/Core/View/productDetailScreen/widget/productMetaData.dart';
import 'package:ecommerce_app_client/Core/View/productDetailScreen/widget/ratingAndShare.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/constants/enum.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
   ProductDetailScreen({super.key , required this.product});
  ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(product: product,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1 - Product Image Slider
            ProductImageSlider(product: product),

            /// 2 - Product Details
            Padding(
              padding: EdgeInsets.only(
                  right: SizesConstant.defaultSpace,
                  left: SizesConstant.defaultSpace,
                  bottom: SizesConstant.defaultSpace),
              child: Column(
                children: [
                  /// - Rating & Share Button
                  RatingAndShare(),

                  /// - Price, Title, Stock, & Brand
                  ProductMetaData(product: product),
                  SizedBox(height: SizesConstant.spaceBtwSection),

                  /// -- Attributes
              if(product.productType == ProductType.variable.toString())    customProductAttributes(product: product),
              if(product.productType == ProductType.variable.toString())      SizedBox(height: SizesConstant.spaceBtwSection),

                  /// -- Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offNamed("/CheckoutScreen");
                      },
                      child: Text('Checkout'),
                    ),
                  ),
                  SizedBox(height: SizesConstant.spaceBtwSection),

                  /// -- Description
                  const SectionHeading(
                      title: 'Description', showActionButton: false),
                  SizedBox(height: SizesConstant.spaceBtwItem),

                  ReadMoreText(
                    product.description ?? "",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// -- Reviews
                  const Divider(),
                  SizedBox(height: SizesConstant.spaceBtwItem),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionHeading(
                          title: 'Reviews (199)', showActionButton: false),
                      IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_rounded,
                              size: 18),
                          onPressed: () {}),
                    ],
                  ), // Row

                  SizedBox(
                    height: SizesConstant.spaceBtwSection,
                  )
                ],
              ), // Column
            ), // Padding
          ],
        ), // Column
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
