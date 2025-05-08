import 'package:ecommerce_app_client/Core/View/cart/widget/cartItem.dart';
import 'package:ecommerce_app_client/Core/View/cart/widget/productQuantityWithAddRemoveButton.dart';
import 'package:ecommerce_app_client/Core/ViewModel/cartVM/cartVM.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/widgets/text/productPriceText.dart';

class CustomCardItems extends StatelessWidget {
  const CustomCardItems({
    super.key,
    this.showWithAddRemoveButton = true,
  });
  final bool showWithAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    final controllCartItem = CartVM.instance;
 return Obx(
    () => ListView.separated(
        shrinkWrap: true,
        itemCount: controllCartItem 
        .cartItems.length,
        separatorBuilder: (_, i) =>  SizedBox(height:SizesConstant
         .spaceBtwSection),
        itemBuilder: (_, index) => Obx(
            () {
                final item = controllCartItem
                .cartItems[index];
                return Column(
                    children: [
                        /// Cart Item
                        CartItem(cartItem: item),
                        if (showWithAddRemoveButton
                        )  SizedBox(height: SizesConstant
         .spaceBtwSection),
                        /// Add Remove Button Row with total Price
                        if (showWithAddRemoveButton
                        )
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Row(
                                        children: [
                                            /// Extra Space
                                            const SizedBox(width: 70),
                                            /// Add Remove Buttons
                                            ProductQuantityWithAddRemoveButton(
                                                quantity: item.quantity,
                                                add: () =>controllCartItem
                                                .addOneToCart(item),
                                                remove: () =>controllCartItem
                                                .removeOneFromCart(item),
                                            ), // TProductQuantityWithAddRemoveButton
                                        ],
                                    ), // Row
                                    /// Product total price
                                    ProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                                ],
                            ), // Row
                    ],
                ); // Column
            }
        ),
    )
    );
  }
}
