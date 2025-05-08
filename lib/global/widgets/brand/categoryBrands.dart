import 'package:ecommerce_app_client/Core/Model/categories.dart';
import 'package:ecommerce_app_client/Core/ViewModel/brandVM/brandVM.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/FirebaseStorageService.dart';
import 'package:ecommerce_app_client/global/widgets/brand/brandShowcase.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/boxesShimmer.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/listTileShimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandViewModel.instance;
    return  FutureBuilder(
          future: controller.getBrandsForCategorySupabase(category.categoryId!),
          builder: (context, snapshot) {
        final  loader =  Column(
              children: [
                const ListTileShimmer(),
                
                SizedBox(height: SizesConstant.spaceBtwItem),
                const BoxesShimmer(),
                 SizedBox(height: SizesConstant.spaceBtwItem)
              ],
            ); // Column
      
            final widget = FirebaseStorageService.checkMultiRecordState(
                snapshot: snapshot, loader: loader);
            if (widget != null) return widget;
      
            /// Record Found!
            final brands = snapshot.data;
      
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brands!.length,
              itemBuilder: (_, index) {
                final brand = brands[index];
                return FutureBuilder(
                  future:
                      controller.getBrandProductsSupabase(brandId: brand.brandId!),
                  builder: (context, snapshot) {
                    /// Handle Loader, No Record, OR Error Message
                    final widget = FirebaseStorageService.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;
      
                    /// Record Found!
                    final products = snapshot.data;
                    return BrandShowcase(
                        brand: brand,
                        images: products!.map((e) => e.thumbnail!).toList());
                  },
                );
              },
            );
          }
    );
  }
}
