import 'package:ecommerce_app_client/Core/Model/brandModel.dart';
import 'package:ecommerce_app_client/Core/View/brand/brandProducts/brandProducts.dart';
import 'package:ecommerce_app_client/Core/ViewModel/brandVM/brandVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/brand/BrandCard.dart';
import 'package:ecommerce_app_client/global/widgets/brand/brandTopProductImage.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:ecommerce_app_client/global/widgets/sortableProduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';








class BrandShowcase extends StatelessWidget {
   BrandShowcase({
    super.key,
    required this.images,
   required this.brand
  });
final BrandModel brand ;
  final List<String> images;
// BrandViewModel brandViewModelControl = Get.put(BrandViewModel());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed("/BrandProducts" ,arguments: brand),  
      child: RoundedContainer(
        showBorder: true,
        borderColor: AppColor.darkGrey,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(SizesConstant.md),
        margin: EdgeInsets.only(bottom: SizesConstant.spaceBtwItem),
        child: Column(
          children: [
          //   // Brand with Products Count
           BrandCard(showBorder: false , brand:brand ,
             
           //   ,  imageUrl:  brandViewModelControl.allBrands.first.logoUrl ,title: brandViewModelControl.allBrands[0].brandName! , count: '250',
              
               ),
            SizedBox(height: SizesConstant.spaceBtwItem),
            // Brand Top 3 Product Images
            Row(
              children: images
                  .map((image) => brandTopProductImage(image, context))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
