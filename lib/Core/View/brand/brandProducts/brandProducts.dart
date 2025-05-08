import 'package:ecommerce_app_client/Core/Model/brandModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/brandVM/brandVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/productVM/productVM.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/brand/BrandCard.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:ecommerce_app_client/global/widgets/sortableProduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/Images.dart';
import '../../../../global/function/FirebaseStorageService.dart';
import '../../../../global/widgets/shimmer/verticalProductShimmer.dart';


class BrandProducts extends StatelessWidget {
     BrandProducts({super.key, required this.brand});

    final BrandModel brand;

    @override
    Widget build(BuildContext context) {
        final controller = BrandViewModel.instance;
        return Scaffold(
            appBar: Customappbar(title: Text(brand.brandName!) , showBackArrow: true, onPressed: ()=>
             Get.toNamed("/Navigationmenu")),
            body: SingleChildScrollView( 
                child: Padding(
                    padding:  EdgeInsets.all(SizesConstant.defaultSpace),
                    child: Column(
                        children: [
                            // Brand Detail
                            BrandCard(showBorder: true, brand: brand),
                             SizedBox(height: SizesConstant.spaceBtwSection),

                            FutureBuilder(
                                future: controller.getBrandProductsSupabase( brandId:brand.brandId! , ),
                                builder: (context, snapshot) {
                                    // Handle Loader, No Record, OR Error Message
                                    const loader = VerticalProductShimmer();
                                    final widget = FirebaseStorageService.checkMultiRecordState(snapshot: snapshot, loader: loader);
                                    if (widget != null) return widget;

                                      final brandProducts = snapshot.data;
                                    return SortableProducts(products: brandProducts!);
                                },
                            ), // FutureBuilder
                        ],
                    ), // Column
                ), // Padding
            ), // SingleChildScrollView
        ); // Scaffold
    }
}









// class BrandProducts extends StatelessWidget {
//    BrandProducts({super.key});
//  BrandViewModel brandViewModelControl = Get.put(BrandViewModel());
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: Customappbar(title: Text('Mike'),
//       showBackArrow: true,
//       onPressed: ()=>  Get.offNamed("/Navigationmenu")
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(SizesConstant.defaultSpace),
//           child: Column(
//             children: [
//               // Brand Detail
//               Obx(() =>  BrandCard(showBorder: true ,imageUrl: brandViewModelControl.allBrands.first.logoUrl ,title: brandViewModelControl.allBrands[0].brandName! , count: '250',)),
//               SizedBox(height: SizesConstant.spaceBtwSection),
//               SortableProducts(),
//             ],
//           ), // Column
//         ), // Padding
//       ), // SingleChildScrollView
//     ); // Scaffold
//   }
// }