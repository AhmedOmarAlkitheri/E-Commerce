import 'package:ecommerce_app_client/Core/View/allProduct/allProduct.dart';
import 'package:ecommerce_app_client/Core/View/brand/allBrandsScreen/allBrandsScreen.dart';
import 'package:ecommerce_app_client/Core/ViewModel/category/categoryViewModel.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/brand/BrandCard.dart';
import 'package:ecommerce_app_client/global/widgets/Layout/gridLayout.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customTabBar.dart';
import 'package:ecommerce_app_client/global/widgets/categoryTab.dart';
import 'package:ecommerce_app_client/global/widgets/customBadge.dart';
import 'package:ecommerce_app_client/global/widgets/customSearch.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/BrandsShimmer.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ViewModel/brandVM/brandVM.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({super.key});
  BrandViewModel brandViewModelControl = Get.put(BrandViewModel());
  final categoryViewModel = Get.put(CategoryViewModel());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categoryViewModel.featuredCategories.length,
      child: Scaffold(
        appBar: Customappbar(
          title: Text("المتجر"),
          actions: [
            customBadge(context: context, onPressed: () {}),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: Helperfunction.isDarkMode(context)
                    ? AppColor.black
                    : AppColor.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(SizesConstant.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: SizesConstant.spaceBtwItem),
                      customSearch(
                        onTap: () {},
                        title: 'البحث عن منتجك',
                        showBorder: true,
                        showColor: false,
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(height: SizesConstant.spaceBtwSection),
                      SectionHeading(
                        title: "العلامات التجارية المميزة",
                        onPressed: () => Get.to(AllBrandsScreen()),
                      ),
                      SizedBox(height: SizesConstant.spaceBtwItem / 1.5),

                      Obx(
                        () {
                          if (brandViewModelControl.isLoading.value)
                            return const BrandsShimmer();
                          if (brandViewModelControl.featuredBrands.isEmpty) {
                            return Center(
                                child: Text('لا يوجد براند',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(color: Colors.white)));
                          }
                          return GridLayout(
                            itemCount:
                                brandViewModelControl.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand =
                                  brandViewModelControl.featuredBrands[index];
                              return BrandCard(showBorder: true, brand: brand);
                            },
                          ); // TGridLayout
                        },
                      ),

                      // Obx(
                      //   () => GridLayout(
                      //       itemCount: brandViewModelControl.allBrands.length,
                      //       mainAxisExtent: 80,
                      //       itemBuilder: (p0, index) {
                      //         return BrandCard(
                      //             showBorder: true,
                      //             brand:
                      //                 brandViewModelControl.allBrands[index]);
                      //         // imageUrl: brandViewModelControl.allBrands.first.logoUrl
                      //         // ,title: brandViewModelControl.allBrands[0].brandName!
                      //         // , count: '250',);
                      //       }),
                      // ),
                    ],
                  ),
                ),
                bottom: CustomTabBar(
                    tab: categoryViewModel.featuredCategories
                        .map(
                          (category) => Tab(
                              child: Text("${category.categoryName}")
                              //, style: TextStyle(color:  Helperfunction.isDarkMode(context)? AppColor.white : AppColor.black),
                              ),
                        )
                        .toList()),
              ),
            ];
          },
          body: Obx(
            () => TabBarView(
                children: categoryViewModel.featuredCategories
                    .map((category) => CategoryTab(category: category))
                    .toList()),
          ),
        ),
      ),
    );
  }
}
