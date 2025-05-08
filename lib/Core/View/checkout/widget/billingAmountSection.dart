import 'package:ecommerce_app_client/Core/ViewModel/cartVM/cartVM.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:flutter/material.dart';

import '../../../../global/function/pricingCalculator.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartVM.instance;
    final subTotal = cartController.totalCartPrice.value;

    return Column(
      children: [
        /// SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$$subTotal', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ), // Row
         SizedBox(height: SizesConstant.spaceBtwItem / 2),
        /// Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text(
                '\$${PricingCalculator.calculateShippingCost(subTotal, 'YE')}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ), // Row
         SizedBox(height:  SizesConstant.spaceBtwItem / 2),

        /// Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${PricingCalculator.calculateTax(subTotal, 'YE')}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ), // Row
         SizedBox(height:  SizesConstant.spaceBtwItem / 2),

        /// Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${PricingCalculator.calculateTotalPrice(subTotal, 'YE')}',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ), // Row
      ],
    );
  }
}






//     return Column(
//       children: [
//         /// SubTotal
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
//             Text('\$256.0', style: Theme.of(context).textTheme.bodyMedium),
//           ],
//         ),
//          SizedBox(height: SizesConstant.spaceBtwItem / 2),

//          /// Shipping Fee
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
//     Text('\$6.0', style: Theme.of(context).textTheme.labelLarge),
//   ],
// ),
//  SizedBox(height: SizesConstant.spaceBtwItem / 2),

// /// Tax Fee
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
//     Text('\$6.0', style: Theme.of(context).textTheme.labelLarge),
//   ],
// ),
//  SizedBox(height: SizesConstant.spaceBtwItem / 2),

// /// Order Total
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
//     Text('\$6.0', style: Theme.of(context).textTheme.titleMedium),
//   ],
// ),