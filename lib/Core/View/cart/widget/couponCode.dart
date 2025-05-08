import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:flutter/material.dart';

class CouponCode extends StatelessWidget {
  const CouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    return RoundedContainer(
      showBorder: true,
      backgroundColor: dark ? AppColor.dark : AppColor.white,
      padding:  EdgeInsets.only(top: SizesConstant.sm, bottom: SizesConstant.sm, right: SizesConstant.sm, left: SizesConstant.md),
      child: Row(
        children: [
          /// TextField
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ), // InputDecoration
            ), // TextFormField
          ), 
        
        /// Button
SizedBox(
  width: 80,
  child: ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      foregroundColor: dark ? AppColor.white.withOpacity(0.5) : AppColor.dark.withOpacity(0.5),
      backgroundColor: Colors.grey.withOpacity(0.2),
      side: BorderSide(color: Colors.grey.withOpacity(0.1)),
    ),
    child: const Text('Apply'),
  ),
),

        ],
      ), // Row
    ); // TRoundedContainer
  }
}