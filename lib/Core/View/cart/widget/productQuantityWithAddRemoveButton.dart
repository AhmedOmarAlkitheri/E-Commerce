import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/CircularIcon.dart';
import 'package:flutter/material.dart';

class ProductQuantityWithAddRemoveButton extends StatelessWidget {
  const ProductQuantityWithAddRemoveButton({
    super.key, required this.quantity, this.add, this.remove,
  });

final int quantity;
final VoidCallback? add, remove;

@override
Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            CircularIcon(
               icon:"${ImagesConstant.minus}",
                width: 32,
                height: 32,
               size: SizesConstant.md,
                color: Helperfunction.isDarkMode(context) ? AppColor.white : AppColor.black,
                backgroundColor: Helperfunction.isDarkMode(context) ?  AppColor.darkerGrey : AppColor.light,
                onPressed: remove,
            ), // TCircularIcon
     
             SizedBox(width: SizesConstant.spaceBtwItem),
            Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
           SizedBox(width: SizesConstant.spaceBtwItem),
            CircularIcon(
             icon:"${ImagesConstant.plus}",
                width: 32,
                height: 32,
               size: SizesConstant.md,
          color: AppColor.white,
         backgroundColor: AppColor.primary,
                onPressed: add,
            ), // TCircularIcon
        ],
    ); // Row
}







  // @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       CircularIcon(
  //         icon:"${ImagesConstant.minus}",
  //         width: 32,
  //         height: 32,
  //         size: SizesConstant.md,
  //         color: Helperfunction.isDarkMode(context) ? AppColor.white : AppColor.black,
  //         backgroundColor: Helperfunction.isDarkMode(context) ? AppColor.darkerGrey : AppColor.light,
  //       ),
  //        SizedBox(width: SizesConstant.spaceBtwItem),
  //       Text('2', style: Theme.of(context).textTheme.titleSmall),
  //        SizedBox(width: SizesConstant.spaceBtwItem),
  //        CircularIcon(
  //         icon:"${ImagesConstant.plus}",
  //         width: 32,
  //         height: 32,
  //         size: SizesConstant.md,
  //         color: AppColor.white,
  //         backgroundColor: AppColor.primary,
  //       ), // TCircularIcon
  //     ],
  //   );
  // }
}