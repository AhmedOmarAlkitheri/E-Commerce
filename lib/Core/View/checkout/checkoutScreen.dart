import 'package:ecommerce_app_client/Core/View/cart/cartScreen.dart';
import 'package:ecommerce_app_client/Core/View/cart/widget/couponCode.dart';
import 'package:ecommerce_app_client/Core/View/cart/widget/customcardItems.dart';
import 'package:ecommerce_app_client/Core/View/checkout/widget/BillingPaymentSection.dart';
import 'package:ecommerce_app_client/Core/View/checkout/widget/billingAddressSection.dart';
import 'package:ecommerce_app_client/Core/View/checkout/widget/billingAmountSection.dart';
import 'package:ecommerce_app_client/Core/View/successScreen.dart/successScreen.dart';
import 'package:ecommerce_app_client/Core/ViewModel/cartVM/cartVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/orderVM/orderVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/function/pricingCalculator.dart';
import 'package:ecommerce_app_client/global/loader/loader.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartVM.instance;
final subTotal = cartController.totalCartPrice.value;
final orderController = Get.put(OrderVM());
final totalAmount = PricingCalculator.calculateTotalPrice(subTotal, 'US');
    final dark = Helperfunction.isDarkMode(context);
    return Scaffold(




/// Checkout Button
bottomNavigationBar: Padding(
    padding:  EdgeInsets.all(SizesConstant.defaultSpace),
    child: ElevatedButton(
        onPressed: subTotal > 0
            ? () => orderController.processOrder(totalAmount)
            : () => Loaders.warningSnackBar(title: 'Empty Cart', message: 'Add items in the cart in order to proceed.'),
        child: Text('Checkout \$${totalAmount}'),
    ),
), 
      appBar: Customappbar(
          showBackArrow: true,
          onPressed: ()=>   Get.offNamed("/CartScreen"),
          title: Text(
            'Order Review',
            
            style: Theme.of(context).textTheme.headlineSmall,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),
          child: Column(
            children: [
              /// -- Items in Cart
              SizedBox(
                  height: 300,
                  child: CustomCardItems(showWithAddRemoveButton: false)),

              SizedBox(height: SizesConstant.spaceBtwSection),

              /// -- Coupon TextField
              CouponCode(),
              SizedBox(height: SizesConstant.spaceBtwSection),

              /// -- Billing Section
              RoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(SizesConstant.md),
                backgroundColor: dark ? AppColor.black : AppColor.white,
                child: Column(
                  children: [
                    /// Pricing
                    BillingAmountSection(),
                    SizedBox(height: SizesConstant.spaceBtwItem),

                    Divider(),
                    SizedBox(height: SizesConstant.spaceBtwItem),
                    // Payment Methods
                    BillingPaymentSection(),
                    SizedBox(height: SizesConstant.spaceBtwItem),
                    // Address Section
                    BillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
