import 'package:ecommerce_app_client/Core/Model/paymentMethodModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/checkoutController.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
        contentPadding: const EdgeInsets.all(0),
        onTap: () {
          controller.selectedPaymentMethod.value = paymentMethod;
          Get.back();
        },
        leading: RoundedContainer(
          width: 60,
          height: 40,
          backgroundColor: Helperfunction.isDarkMode(context)
              ? AppColor.light
              : AppColor.white,
          padding: EdgeInsets.all(SizesConstant.sm),
          child: Image(
              image: AssetImage(paymentMethod.image), fit: BoxFit.contain),
        ), // TRoundedContainer
        title: Text(paymentMethod.name),
        trailing: const Icon(
          Icons.arrow_back,
        )); // ListTile
  }
}
