import 'package:ecommerce_app_client/Core/View/brand/brandProducts/brandProducts.dart';
import 'package:ecommerce_app_client/Core/View/store/storeScreen.dart';
import 'package:ecommerce_app_client/Core/ViewModel/brandVM/brandVM.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/Layout/gridLayout.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/brand/BrandCard.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/BrandsShimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/Images.dart';
import '../../../../global/widgets/text/sectionHeading.dart';

class AllBrandsScreen extends StatelessWidget {
   AllBrandsScreen({super.key});
 BrandViewModel brandViewModelControl = Get.put(BrandViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  Customappbar(title: Text('Brand'), showBackArrow: true , onPressed: ()=>  Get.offNamed("/Navigationmenu"),),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(SizesConstant.defaultSpace),
          child: Column(
            children: [
              // Heading
              const SectionHeading(title: 'Brands', showActionButton: false),
               SizedBox(height: SizesConstant.spaceBtwItem),
              // Brands

Obx(() {
    if (brandViewModelControl.isLoading.value) return const BrandsShimmer();
        if (brandViewModelControl.allBrands.isEmpty) {
            return Center(
                child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
        }
        return GridLayout(
            itemCount: brandViewModelControl.allBrands.length,
            mainAxisExtent: 80,
            itemBuilder: (_, index) {
                final brand = brandViewModelControl.allBrands[index];
                return BrandCard(showBorder: true, brand: brand ,  onTap: () =>   Get.toNamed("/BrandProducts" , arguments:brand ), );
            },
        );
},),
       
       


              //  Obx(() =>  GridLayout(
              //     itemCount: brandViewModelControl.allBrands.length ?? 0,
              //     mainAxisExtent: 80,
              //     itemBuilder: (context, index) => BrandCard(
              //       showBorder: true,  
              //       brand: ,
              //    //   imageUrl: brandViewModelControl.allBrands.first.logoUrl ,title: brandViewModelControl.allBrands[0].brandName! , count: '250',
              //       onTap: () =>   Get.toNamed("/BrandProducts"), 
              //     ),
              //   ),
              // ), // TGridLayout
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}