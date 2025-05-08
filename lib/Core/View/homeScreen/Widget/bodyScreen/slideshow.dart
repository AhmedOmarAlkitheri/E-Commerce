import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app_client/Core/View/homeScreen/Controller/HomeController.dart';
import 'package:ecommerce_app_client/Core/View/homeScreen/Widget/headerScreen/CircularContainer.dart';
import 'package:ecommerce_app_client/Core/View/store/storeScreen.dart';
import 'package:ecommerce_app_client/Core/ViewModel/sliderBanner/sliderBannerViewModel.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/images/roundedImage.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/shimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../global/constants/Images.dart';

class SliderShow extends StatelessWidget {
  const SliderShow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SliderBannerViewModel());
    return Obx(() {
      if (controller.isLoading.value) {
        return ShimmerEffect(width: double.infinity, height: 190);
      }

          if (controller.allsliderbanner.isEmpty) {
              return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
      
      }
    return  Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index),
            ),
            items: controller.allsliderbanner
                .map((banner) => RoundedImage(
                      imageUrl: banner.imageUrl ?? ImagesConstant.Dominos,
                      isNetworkImage: true,
                      onPressed: () {
                        Get.toNamed("/StoreScreen");
                      },
                    ))
                .toList(),
          ),
          SizedBox(
            height: SizesConstant.spaceBtwItem,
          ),
          Center(
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.allsliderbanner.length; i++)
                    CircularContainer(
                      width: 20,
                      height: 4,
                      margin: EdgeInsets.only(right: 10),
                      backgroundColor:
                          controller.carouselCurrentIndex.value == i
                              ? AppColor.primary
                              : AppColor.grey,
                    ),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
