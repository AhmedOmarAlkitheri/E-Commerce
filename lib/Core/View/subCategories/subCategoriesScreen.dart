import 'package:ecommerce_app_client/Core/Model/categories.dart';
import 'package:ecommerce_app_client/Core/ViewModel/category/categoryViewModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/productVM/productVM.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/FirebaseStorageService.dart';
import 'package:ecommerce_app_client/global/widgets/Layout/gridLayout.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/images/roundedImage.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/horizontalProductShimmer.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/verticalProductShimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/widgets/product_card/productCardHorizontal.dart';
import '../../../global/widgets/text/sectionHeading.dart';

class SubCategoriesScreen extends StatelessWidget {
   SubCategoriesScreen({super.key, required this.category});
  CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final categoryvm = CategoryViewModel.instance;
    return Scaffold(
      appBar: Customappbar(
        title: Text(category.categoryName ?? ""),
        showBackArrow: true,
        onPressed: () => Get.offNamed("/Navigationmenu"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),
          child: Column(
            children: [
              // Banner
              RoundedImage(
                isNetworkImage: true,
                width: double.infinity,
                height: 190,
                imageUrl: category.categoryImageUrl ??  ImagesConstant.Dominos,
                applyImageRadius: true,
              ),
              SizedBox(height: SizesConstant.spaceBtwSection),

              // Sub-Categories
// Sub-Categories
FutureBuilder(
    future:   // categoryvm.  getCategoryProducts(categoryId: category.categoryId!),
   categoryvm.getSubCategoriesSupabase(category.categoryId!),
    builder: (context, snapshot) {
        // Handle Loader, No Record, OR Error Message
        const loader = HorizontalProductShimmer();
        final widget = FirebaseStorageService.checkMultiRecordState(snapshot: snapshot, loader: loader);
        if (widget != null) return widget;

        // Record found.
        final subCategories = snapshot.data!;

        return
 ListView.builder(
            shrinkWrap: true,
            itemCount: subCategories.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
                final subCategory = subCategories[index];
              
                return FutureBuilder(
                    future: categoryvm.getCategoryProductsSupabase(categoryId: subCategory.categoryId!),
                    builder: (context, snapshot) {
                        // Handle Loader, No Record, OR Error Message
                        final widget = FirebaseStorageService.checkMultiRecordState(snapshot: snapshot, loader: loader);
                        if (widget != null) return widget;

                        // Congratulations! Record found.
                        final products = snapshot.data!;


return Column(
    children: [
        // Heading
        SectionHeading(
            title: subCategory.categoryName!,
            onPressed: () => Get.toNamed(
             "/AllProducts"  ,arguments: {
                    "title": subCategory.categoryName,
                    "futureMethod": categoryvm.getCategoryProductsSupabase(categoryId: subCategory.categoryId!, limit: -1),
                      }   // AllProducts
            ),
        ), // TSectionHeading
         SizedBox(height:  SizesConstant.spaceBtwItem / 2),

        SizedBox(
            height: 120,
            child: ListView.separated(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) =>  SizedBox(width: SizesConstant.spaceBtwItem),
                itemBuilder: (context, index) => ProductCardHorizontal(product: products[index]),
            ), // ListView.separated
        ), // SizedBox
    ],
); 

                    }
                    );
                    }
        );
    }
)
          

                    
                
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
