import 'package:ecommerce_app_client/Core/View/cart/widget/customcardItems.dart';
import 'package:ecommerce_app_client/Core/View/checkout/checkoutScreen.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/loader/animationLoaderWidget.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ViewModel/cartVM/cartVM.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controllCartItem = CartVM.instance;
    return Scaffold(
       appBar: Customappbar(
        onPressed: ()=>  Get.offAllNamed("/Navigationmenu"),
          showBackArrow: true,
          title:
              Text('السلة', style: Theme.of(context).textTheme.headlineSmall)),

    
body: Obx(
    () {
        // Nothing Found Widget
        final emptyWidget = AnimationLoaderWidget(
            text: 'Whoops! Cart is EMPTY.',
            animation: ImagesConstant.successfully_done,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => 
             Get.offAllNamed("/Navigationmenu")
        ); // TAnimationLoaderWidget

        if (controllCartItem
        .cartItems.isEmpty) {
            return emptyWidget;
        } else {
            return  SingleChildScrollView(
                child: Padding( 
                    padding: EdgeInsets.all(SizesConstant.defaultSpace),
                    /// -- Items in Cart
                    child: CustomCardItems()
                ), // Padding
            ); // SingleChildScrollView
        }
    },
), // Obx

// Checkout Button
bottomNavigationBar: controllCartItem
.cartItems.isEmpty ? SizedBox() : Padding(
    padding:  EdgeInsets.all(SizesConstant.defaultSpace),
    child: ElevatedButton(
        onPressed: () => Get.to(() => const CheckoutScreen()),
        child: Obx(() => Text('Checkout \$${controllCartItem
        .totalCartPrice.value}')),
    ), // ElevatedButton
), // Padding
); // Scaffold
  }
}


/*
  bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            right: SizesConstant.defaultSpace,
            left: SizesConstant.defaultSpace,
            bottom: SizesConstant.defaultSpace),
        child: ElevatedButton(
            onPressed: () {
        

              Get.offNamed("/CheckoutScreen");
            },
            child: const Text('إتمام الشراء  \$256.0')),
      ),
     
      body: Padding(
        padding: EdgeInsets.all(SizesConstant.defaultSpace),
        child: CustomCardItems(), // ListView.separated
      ),

*/