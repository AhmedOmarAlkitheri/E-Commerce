import 'package:ecommerce_app_client/Core/View/allProduct/allProduct.dart';
import 'package:ecommerce_app_client/Core/View/cart/cartScreen.dart';
import 'package:ecommerce_app_client/Core/View/homeScreen/Widget/headerScreen/VerticalImageText.dart';
import 'package:ecommerce_app_client/Core/View/homeScreen/Widget/headerScreen/curvedHeader.dart';
import 'package:ecommerce_app_client/Core/View/profile/widget/deleteWidget.dart';
import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/category/categoryViewModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/productVM/productVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/sliderBanner/sliderBannerViewModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/user/user.dart';
import 'package:ecommerce_app_client/Core/server/authController.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/widgets/customBadge.dart';
import 'package:ecommerce_app_client/global/widgets/Layout/gridLayout.dart';
import 'package:ecommerce_app_client/global/widgets/product_card/productCardVertical.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/categoryShimmer.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/customSearch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/widgets/shimmer/verticalProductShimmer.dart';
import '../subCategories/subCategoriesScreen.dart';
import 'Widget/bodyScreen/slideshow.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  CategoryViewModel categoryViewModel = Get.put(CategoryViewModel());
  SliderBannerViewModel sliderBannerViewModel =
      Get.put(SliderBannerViewModel());
  //  AuthController authControllers = Get.put(AuthController(useFirebase: false));
  final userVM = UserVM.instance;
  Productvm productvm = Get.put(Productvm());
// Get.put(UserVM(authController: AuthController(useFirebase: true)))
  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            curvedHeader(
              child: Column(
                children: [
                  Customappbar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "يوم جيد للتسوق",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(color: AppColor.grey),
                        ),
                        Obx(
                          () {
                            if (userVM.loadingProfile.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                              // return ShimmerEffect(
                              //   width: 88,
                              //   height: 12,
                              //   color: AppColor.black,
                              // );
                            }

                            return Text(
                              userVM.userModel.value.user_name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .apply(color: AppColor.white),
                            );
                          },
                        ),
                      ],
                    ),
                    actions: [
                      customBadge(
                          context: context,
                          onPressed: () {
                            Get.offAllNamed("/CartScreen");
                          },
                          color: AppColor.white)
                    ],
                  ),
                  SizedBox(
                    height: SizesConstant.spaceBtwSection,
                  ),
                  customSearch(
                    title: "البحث عن منتجك",
                    onTap: () {},
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizesConstant.defaultSpace),
                    child: Column(
                      children: [
                        SectionHeading(
                          title: "الفئات الشائعة",
                          showActionButton: false,
                          textColor: AppColor.white,
                        ),
                        SizedBox(
                          height: SizesConstant.spaceBtwItem,
                        ),
                        Obx(() {
                          if (categoryViewModel.isLoading.value)
                            return CategoryShimmer();
                          if (categoryViewModel.categorymodel.isEmpty) {
                            return Center(
                              child: Text(
                                "لاتوجد تصنيفات",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: AppColor.white),
                              ),
                            );
                          }

                          return SizedBox(
                            height: 82,
                            child: ListView.builder(
                              itemCount:
                                  categoryViewModel.featuredCategories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final category =
                                    categoryViewModel.featuredCategories[index];
                                return VerticalImageText(
                                  image: category.categoryImageUrl ??
                                      ImagesConstant.logo,
                                  title: "${category.categoryName}",
                                  onTap: () {
                                    Get.toNamed("/SubCategoriesScreen",
                                        arguments: category);
                                  },
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizesConstant.spaceBtwSection,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(SizesConstant.defaultSpace),
              child: Column(children: [
                Obx(() {
                  if (sliderBannerViewModel.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SliderShow();
                }),

                SizedBox(
                  height: SizesConstant.spaceBtwSection,
                ),

                // Padding(
                //   padding: EdgeInsets.all(SizesConstant.defaultSpace),
                //   child: SectionHeading(
                //     title: "المنتجات الشائعة",
                //     showActionButton: true,
                //     textColor: AppColor.white,
                //     buttonTitle: "عرض الكل",
                //   ),
                // ),
                SectionHeading(
                  title: "المنتجات الشائعة",
                  onPressed: () => Get.toNamed(
                    "/AllProducts",
                    arguments: {
                      'title': "المنتجات الشائعة",
                      'futureMethod': productvm.fetchFeaturedProductSupabase(),
                    },
                  ),
                ),
                SizedBox(
                  height: SizesConstant.spaceBtwItem,
                ),

                Obx(() {
                  if (productvm.isLoading.value)
                    return const VerticalProductShimmer();
                  if (productvm.featuredProducts.isEmpty) {
                    return Center(
                        child: Text('لا توجد منتجات',
                            style: Theme.of(context).textTheme.bodyMedium));
                  }
                  return GridLayout(
                    itemCount: productvm.featuredProducts.length,
                    itemBuilder: (_, index) => ProductCardVertical(
                        product: productvm.featuredProducts[index]),
                  ); // TGridLayout
                })
              ]),
            ),
            SizedBox(
              height: SizesConstant.spaceBtwSection * 2,
            ),
          ],
        ),
      ),
    );
  }
}
