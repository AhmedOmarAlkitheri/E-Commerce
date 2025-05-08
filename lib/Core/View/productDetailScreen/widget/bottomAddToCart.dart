import 'package:ecommerce_app_client/Core/Model/productModel.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/widgets/circularIcon.dart';
import '../../../ViewModel/cartVM/cartVM.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    final controllCartItem = CartVM.instance;
    controllCartItem.updateAlreadyAddedProductCount(product);

    return Container(
      padding:  EdgeInsets.symmetric(
          horizontal:  SizesConstant.defaultSpace ,
          
           vertical: SizesConstant.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ?AppColor.darkerGrey : AppColor.light,
          borderRadius:  BorderRadius.only(
          
                 topLeft: Radius.circular(SizesConstant.cardRadiusLg),
         topRight: Radius.circular(SizesConstant.cardRadiusLg),
          )), // BorderRadius.only, BoxDecoration
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircularIcon(
                  icon:  ImagesConstant.minus,
                  backgroundColor: AppColor.darkerGrey,
                  width: 40,
                  height: 40,
                  color:  AppColor.white,
                  onPressed: () => controllCartItem
                  .productQuantityInCart.value < 1
                      ? null
                      : controllCartItem
                      .productQuantityInCart.value -= 1,
                ), // TCircularIcon
                 SizedBox(width: SizesConstant.spaceBtwItem),
                Text(controllCartItem
                .productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall),
                 SizedBox(width:  SizesConstant.spaceBtwItem),
                CircularIcon(
                  icon: ImagesConstant.plus,
                  backgroundColor: AppColor.black,
                  width: 40,
                  height: 40,
                  color:  AppColor.white,
                  onPressed: () => controllCartItem
                  .productQuantityInCart.value += 1,
                ), // TCircularIcon
              ],
            ), // Row

            ElevatedButton(
              onPressed: controllCartItem
              .productQuantityInCart.value < 1
                  ? null
                  : () => controllCartItem
                  .addToCart(product),
              style: ElevatedButton.styleFrom(
                padding:  EdgeInsets.all(SizesConstant
                .md),
                backgroundColor:AppColor.black,
                side: const BorderSide(color: AppColor.black,),
              ),
              child: const Text('Add to Cart'),
            ) // ElevatedButton
          ],
        ),
      ),
    );

    // return Container(
    //   padding: EdgeInsets.symmetric(
    //       horizontal: SizesConstant.defaultSpace,
    //       vertical: SizesConstant.defaultSpace / 2),
    //   decoration: BoxDecoration(
    //     color: dark ? AppColor.darkerGrey : AppColor.light,
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(SizesConstant.cardRadiusLg),
    //       topRight: Radius.circular(SizesConstant.cardRadiusLg),
    //     ),
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         children: [
    //           CircularIcon(
    //             icon: ImagesConstant.minus,
    //             size: 27,
    //             backgroundColor: AppColor.darkGrey,
    //             width: 40,
    //             height: 40,
    //             color: AppColor.white,
    //           ), // TCircularIcon
    //           SizedBox(width: SizesConstant.spaceBtwItem),
    //           Text('2', style: Theme.of(context).textTheme.titleSmall),
    //           SizedBox(width: SizesConstant.spaceBtwItem),
    //           CircularIcon(
    //             size: 27,
    //             icon: ImagesConstant.plus,
    //             backgroundColor: AppColor.black,
    //             width: 40,
    //             height: 40,
    //             color: AppColor.white,
    //           ), // TCircularIcon
    //         ],
    //       ), // Row

    //       ElevatedButton(
    //         onPressed: () {},
    //         style: ElevatedButton.styleFrom(
    //           padding: EdgeInsets.all(SizesConstant.md),
    //           backgroundColor: AppColor.black,
    //           side: const BorderSide(color: AppColor.black),
    //         ),
    //         child: const Text('Add to Cart'),
    //       ) // ElevatedButton
    //     ],
    //   ), // Row
    // );
  }
}
