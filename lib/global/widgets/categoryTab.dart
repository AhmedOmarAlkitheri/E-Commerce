import 'package:ecommerce_app_client/Core/Model/categories.dart';
import 'package:ecommerce_app_client/Core/View/allProduct/allProduct.dart';
import 'package:ecommerce_app_client/Core/ViewModel/brandVM/brandVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/category/categoryViewModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/productVM/productVM.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/FirebaseStorageService.dart';
import 'package:ecommerce_app_client/global/widgets/Layout/gridLayout.dart';
import 'package:ecommerce_app_client/global/widgets/brand/brandShowcase.dart';
import 'package:ecommerce_app_client/global/widgets/brand/categoryBrands.dart';
import 'package:ecommerce_app_client/global/widgets/product_card/productCardVertical.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'shimmer/verticalProductShimmer.dart';

class CategoryTab extends StatelessWidget {
  CategoryTab({super.key, required this.category});
  CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryViewModel());


     return 
      ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                  Padding(
                      padding:  EdgeInsets.all(SizesConstant.defaultSpace),
                      child: Column(
                          children: [
                              // -- Brands
                              CategoryBrands(category: category),
                               SizedBox(height: SizesConstant.spaceBtwItem),
       
                              // -- Products
                              FutureBuilder(
                                  future: controller.getCategoryProductsSupabase(categoryId: category.categoryId!),
                                  builder: (context, snapshot) {
                                      // Helper Function: Handle Loader, No Record, OR ERROR Message
                                      final response = FirebaseStorageService.checkMultiRecordState(snapshot: snapshot, loader: const VerticalProductShimmer());
                                      if (response != null) return response;
       
                                      // Record Found!
                                      final products = snapshot.data;
       
       
       
       return Column(
           children: [
          SectionHeading(
              title: 'You might like',
              onPressed: () => 
              
              
            Get.toNamed("/AllProducts" , 
               
                     arguments: {
                          'title': category.categoryName ?? "",
                          'futureMethod': 
                          controller.getCategoryProductsSupabase(categoryId: category.categoryId!, limit: -1),
                         
                      
                     }
                        ,),
          ), // TSectionHeading
           SizedBox(height: SizesConstant.spaceBtwItem),
          GridLayout(itemCount: products!.length, itemBuilder: (_, index) => ProductCardVertical(product: products[index])),
           ],
       ); // Column
                                  }
                              )
              ],
            ),
          ),
        ],
        
     );
   
  }
}



 // return ListView(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   children: [
    //     Padding(
    //       padding: EdgeInsets.all(SizesConstant.defaultSpace),
    //       child: Column(
    //         children: [
    //           // -- Brands
    //           FutureBuilder(
    //             future: controller.getCategorysForProducts(
    //                 categoryId: category.categoryId!, limit: 3),
    //             builder: (context, snapshot) {
    //               // Handle Loader, No Record, OR Error Message
    //               const loader = ShimmerEffect(width: double.infinity, height: 200,);
    //               final widget = FirebaseStorageService.checkMultiRecordState(
    //                   snapshot: snapshot, loader: loader);
    //               if (widget != null) return widget;

    //               final categoryProducts = snapshot.data;

    //               return 
                  
    //               BrandShowcase(
    //                   images: categoryProducts!.map((e) => e.thumbnail,).toList() 
                      
    //                   );
    //             },
    //           ), // FutureBuilder
    //           // BrandShowcase(images: [
    //           //   ImagesConstant.Dominos,
    //           //   ImagesConstant.OuP,
    //           //   ImagesConstant.OuP5,
    //           // ]),
    //           // BrandShowcase(images: [
    //           //   ImagesConstant.Dominos,
    //           //   ImagesConstant.OuP,
    //           //   ImagesConstant.OuP5,
    //           // ]),
    //           SizedBox(height: SizesConstant.spaceBtwItem),

    //           // -- Products // featuredProducts
    //           SectionHeading(
    //             title: 'You might like',
    //             onPressed: () => Get.to(AllProducts()),
    //           ),
    //           SizedBox(height: SizesConstant.spaceBtwItem),

    //           FutureBuilder(
    //             future: controller.getCategoryProducts(category.categoryId!),
    //             builder: (context, snapshot) {
    //               // Handle Loader, No Record, OR Error Message
    //               const loader = VerticalProductShimmer();
    //               final widget = FirebaseStorageService.checkMultiRecordState(
    //                   snapshot: snapshot, loader: loader);
    //               if (widget != null) return widget;

    //               final categoryProducts = snapshot.data;
    //               return GridLayout(
    //                 itemCount: categoryProducts!.length,
    //                 itemBuilder: (_, index) => ProductCardVertical(
    //                   product: categoryProducts[index],
    //                 ),
    //               );
    //             },
    //           ),

    //           SizedBox(height: SizesConstant.spaceBtwSection),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
