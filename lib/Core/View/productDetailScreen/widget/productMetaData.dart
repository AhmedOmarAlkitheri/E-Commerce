import 'package:ecommerce_app_client/Core/Model/productModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/productVM/productVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/constants/enum.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/images/circularImage.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:ecommerce_app_client/global/widgets/text/brandTitleWithVerifiedIcon.dart';
import 'package:flutter/material.dart';

import '../../../../global/widgets/text/productPriceText.dart';
import '../../../../global/widgets/text/productTitleText.dart';

class ProductMetaData extends StatelessWidget {
   ProductMetaData({
    super.key, required this.product
  });
ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Productvm.instance;
final salePercentage = controller.calculateSalePercentage(product.price!, product.salePrice);
    final darkMode = Helperfunction.isDarkMode(context);
    return Column(
    
       crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        // Price & Sale Price
        Row(
            children: [
                // Sale Tag
                RoundedContainer(
                    radius: SizesConstant.sm,
                    backgroundColor: AppColor.secondary.withOpacity(0.8),
                    padding:  EdgeInsets.symmetric(horizontal: SizesConstant.sm, vertical: SizesConstant.xs),
                    child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: AppColor.black)),
                ),

SizedBox(width: SizesConstant.spaceBtwItem),

if (product.productType == ProductType.single.toString() && product.salePrice! > 0)
    Text('\$${product.price}', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
if (product.productType == ProductType.single.toString() && product.salePrice! > 0)  SizedBox(width: SizesConstant.spaceBtwItem),
ProductPriceText(price: controller.getProductPrice(product), isLarge: true),
            ]
),
// Row
 SizedBox(height: SizesConstant.spaceBtwItem / 1.5),

// Title
ProductTitleText(title: product.title!),
 SizedBox(height: SizesConstant.spaceBtwItem / 1.5),

// Stock Status
Row(
    children: [
        const ProductTitleText(title: 'Status'),
         SizedBox(width:  SizesConstant.spaceBtwItem),
        Text(controller.getProductStockStatus(product.stock!), style: Theme.of(context).textTheme.titleMedium),
    ],
),
// Row
 SizedBox(height: SizesConstant.spaceBtwItem / 1.5),

// Brand
Row(
    children: [
        circularImage(
          isNetworkImage: true,
          imageUrl: 
           product.brand != null ? product.brand!.logoUrl! : '',
            width: 32,
            height: 32,
            overlayColor: darkMode ? AppColor.white : AppColor.black,
        ),
        // TCircularImage
        BrandTitleWithVerifiedIcon(title: product.brand != null ? product.brand!.brandName! : '', brandTextSize: TextSizes.medium),
    ],
),



      ],
    ); // Column
  }
}




//             /// Price
//             Text('\$250',
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleSmall!
//                     .apply(decoration: TextDecoration.lineThrough)),

//             SizedBox(width: SizesConstant.spaceBtwItem),
//             ProductPriceText(price: '175', isLarge: true),
//           ],
//         ),

//         SizedBox(height: SizesConstant.spaceBtwItem / 1.5),

//         // Title
//         const ProductTitleText(title: 'جوال سامسونغ 20S '),
//         SizedBox(height: SizesConstant.spaceBtwItem / 1.5),

// // Stock Status
//         Row(
//           children: [
//             const ProductTitleText(title: 'Status:'),
//             SizedBox(width: SizesConstant.spaceBtwItem),
//             Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
//           ],
//         ), // Row
//         SizedBox(height: SizesConstant.spaceBtwItem / 1.5),

// // Brand
//         Row(
//           children: [
//             circularImage(
//               imageUrl: ImagesConstant.logo,
//               border: Border.all(
//                 color: darkMode ? AppColor.white : AppColor.black,
//               ),
//               width: 32,
//               height: 32,
//               overlayColor: darkMode ? AppColor.white : AppColor.black,
//             ),
//             SizedBox(width: SizesConstant.spaceBtwItem / 1.5),
//             const BrandTitleWithVerifiedIcon(
//                 title: 'ابل', brandTextSize: TextSizes.medium),
//           ],
//         ), // Row
