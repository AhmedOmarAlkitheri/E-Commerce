import 'package:ecommerce_app_client/Core/Model/carlItemModel.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/images/roundedImage.dart';
import 'package:ecommerce_app_client/global/widgets/text/brandTitleWithVerifiedIcon.dart';
import 'package:flutter/material.dart';

import '../../../../global/widgets/text/productTitleText.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key, required this.cartItem,
  });
  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
   
    return Row(
      children: [



// Image
RoundedImage(
  isNetworkImage: true,
    imageUrl: cartItem.image ?? '',
    width: 60,
    height: 60,
    padding:  EdgeInsets.all(SizesConstant.sm),
    backgroundColor: Helperfunction.isDarkMode(context) ?  AppColor.darkerGrey : AppColor.light,
), // TRoundedImage
 SizedBox(width: SizesConstant.spaceBtwItem),

// Title, Price, & Size
Expanded(
    child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            BrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
            Flexible(child: ProductTitleText(title: cartItem.title, maxLines: 1)),
            // Attributes
            Text.rich(
                TextSpan(
                    children: (cartItem.selectedVariation ?? {})
                        .entries
                        .map(
                            (e) => TextSpan(
                                children: [
                                    TextSpan(text: ' ${e.key} ', style: Theme.of(context).textTheme.bodySmall),
                                    TextSpan(text: '${e.value} ', style: Theme.of(context).textTheme.bodyLarge),
                                ],
                            ), // TextSpan
                        )
                        .toList(),
                ), // TextSpan
            ) // Text.rich
        ],
    ), // Column
) // Expanded












      ],
    );
  }
}

/*



    RoundedImage(
          imageUrl: ImagesConstant.OuP5,
          width: 60,
          height: 60,
          padding:  EdgeInsets.all(SizesConstant.sm),
          backgroundColor: Helperfunction.isDarkMode(context) ? AppColor.darkerGrey : AppColor.light,
        ),
         SizedBox(width: SizesConstant.spaceBtwItem),

        /// Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandTitleWithVerifiedIcon(title: 'سامسونغ'),
              const Flexible(child: ProductTitleText(title: 'جوال سامسونغ رمادي', maxLines: 1)),
              /// Attributes
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'اللون ', style: Theme.of(context).textTheme.bodySmall),
                     TextSpan(text: 'رمادي', style: Theme.of(context).textTheme.bodyLarge),
                      TextSpan(text: 'المقاس ', style: Theme.of(context).textTheme.bodySmall),
                       TextSpan(text: '45', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
        ),





*/
