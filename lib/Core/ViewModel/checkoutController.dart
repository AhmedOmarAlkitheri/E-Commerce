import 'package:ecommerce_app_client/Core/Model/paymentMethodModel.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/paymentTile.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: ImagesConstant.paypal_2);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(SizesConstant.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                  title: 'Select Payment Method', showActionButton: false),
              SizedBox(height: SizesConstant.spaceBtwSection),
              PaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paypal', image: ImagesConstant.paypal_1)),
              SizedBox(height: SizesConstant.spaceBtwItem / 2),
                PaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'عند الاستلام', image: ImagesConstant.Dominos)),
                         SizedBox(height: SizesConstant.spaceBtwSection),

            ],
          ), // Column
        ), // Container
      ), // SingleChildScrollView
    );
  }
}
