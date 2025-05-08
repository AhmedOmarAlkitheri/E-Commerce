import 'package:ecommerce_app_client/Core/Model/productModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/cartVM/cartVM.dart';
import 'package:ecommerce_app_client/global/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/Colors.dart';
import '../../../constants/Sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartVM.instance;
    return InkWell(onTap: () {
      // If the product have variations then show the product Details for variation selection.
      // Else add product to the cart.
      if (product.productType == ProductType.single.toString()) {
        final cartItem = cartController.convertToCartItem(product, 1);
        cartController.addOneToCart(cartItem);
      } else {
        Get.toNamed("/ProductDetailScreen", arguments: product);
      }
    }, child: Obx(() {
      final productQuantityInCart =  cartController.getProductQuantityInCart(product.id ?? "");

     

      return    Container(
                          decoration: BoxDecoration(
                            color:  productQuantityInCart > 0 ?  AppColor.primary
                        :    AppColor.dark,
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(SizesConstant.cardRadiusMd),
                              bottomRight: Radius.circular(
                                  SizesConstant.productImageRadius),
                            ),
                          ),
                          child: SizedBox(
                            width: SizesConstant.iconLg * 1.2,
                            height: SizesConstant.iconLg * 1.2,
                            child:  Center(
              child: productQuantityInCart > 0
                  ? Text(productQuantityInCart.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: AppColor.white))
                  : const Icon(Icons.add, color:  AppColor.white),
            ), 
                          ),
                        );

    }));
  }
}
