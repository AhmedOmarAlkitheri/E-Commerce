import 'package:ecommerce_app_client/Core/ViewModel/checkoutController.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});





    @override
    Widget build(BuildContext context) {
        final controller = CheckoutController.instance;

        final dark = Helperfunction.isDarkMode(context);
        return Column(
            children: [
                SectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () => controller.selectPaymentMethod(context)),
                 SizedBox(height: SizesConstant.spaceBtwItem / 2),
                Obx(
                    () => Row(
                        children: [
                            RoundedContainer(
                                width: 60,
                                height: 35,
                                backgroundColor: dark ?  AppColor.light : AppColor.white,
                                padding:  EdgeInsets.all(SizesConstant.sm),
                                child: Image(image: AssetImage(controller.selectedPaymentMethod.value.image), fit: BoxFit.contain),
                            ), // TRoundedContainer
                             SizedBox(width: SizesConstant.spaceBtwItem / 2),
                            Text(controller.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge),
                        ],
                    ), // Row
                ), // Obx
            ],
        ); // Column
    }
}


























//   @override
//   Widget build(BuildContext context) {
//     final dark = Helperfunction.isDarkMode(context);
//     return Column(
//       children: [
//         SectionHeading(
//           title: 'Payment Method',
//           buttonTitle: 'Change',
//           onPressed: () {},
//         ),
//          SizedBox(height: SizesConstant.spaceBtwItem / 2),
//         Row(
//           children: [
//             RoundedContainer(
//               width: 60,
//               height: 35,
//               backgroundColor: dark ? AppColor.light : AppColor.white,
//               padding:  EdgeInsets.all(SizesConstant.sm),
//               child:  Image(
//                 image: AssetImage(ImagesConstant.paypal_2),
//                 fit: BoxFit.contain,
//               ),
//             ),
//              SizedBox(width: SizesConstant.spaceBtwItem / 2),
//             Text(
//               'Paypal',
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }