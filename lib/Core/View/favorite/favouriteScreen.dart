import 'package:ecommerce_app_client/Core/View/homeScreen/homeScreen.dart';
import 'package:ecommerce_app_client/Core/ViewModel/favouritesController.dart';
import 'package:ecommerce_app_client/Core/ViewModel/productVM/productVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/FirebaseStorageService.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';

import 'package:ecommerce_app_client/global/function/navigationController.dart';
import 'package:ecommerce_app_client/global/widgets/Layout/gridLayout.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/circularIcon.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:ecommerce_app_client/global/widgets/product_card/productCardVertical.dart';
import 'package:ecommerce_app_client/global/widgets/shimmer/verticalProductShimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/loader/animationLoaderWidget.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});
  Navigationcontroller selectIndex = Get.find();

  final productvm = Get.put(Productvm());

  @override
  Widget build(BuildContext context) {
    final controllerfavourite = Get.put(FavouritesController());
    final dark = Helperfunction.isDarkMode(context);
    return Scaffold(
      appBar: Customappbar(
        title:
            Text('WishList', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          CircularIcon(
              icon: ImagesConstant.plus,
              color: dark ? AppColor.white : AppColor.black,
              size: 20,
              onPressed: () {
                selectIndex.selectedIndex.value = 0;

//Navigationmenu
                //Get.to(Navigationmenu(selected: 0.obs ,));
                Get.offAllNamed("/Navigationmenu");
              }),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),

          // Products Grid
          child: Obx(
            () => FutureBuilder(
              future: controllerfavourite.favoriteProducts(),
              builder: (context, snapshot) {
                // Nothing Found Widget
                final emptyWidget = AnimationLoaderWidget(
                  text: 'Whoops! Wishlist is Empty...',
                  animation: ImagesConstant.successfully_done,
                  showAction: true,
                  actionText: 'Let\'s add some',
                  onActionPressed: () =>
                      Get.off(() => Get.offAllNamed("/Navigationmenu")),
                ); // TAnimationLoaderWidget

                const loader = VerticalProductShimmer(itemCount: 6);
                final widget = FirebaseStorageService.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                    nothingFound: emptyWidget);
                if (widget != null) return widget;

                final products = snapshot.data!;
                return GridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) =>
                        ProductCardVertical(product: products[index]));
              }, // FutureBuilder
            ),
          ), // Padding
        ), // SingleChildScrollView
      ),

//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(SizesConstant.defaultSpace),
//           child: Column(
//             children: [

// Obx(() {
//     if (productvm.isLoading.value) return const VerticalProductShimmer();
//     if (productvm.featuredProducts.isEmpty) {
//         return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
//     }
//     return GridLayout(
//         itemCount: productvm.featuredProducts.length,
//         itemBuilder: (_, index) => ProductCardVertical(product: productvm.featuredProducts[index]),
//     ); // TGridLayout
// })

//               // GridLayout(
//               //   itemCount: 8,
//               //   itemBuilder: (_, index) =>  ProductCardVertical(product: ,),
//               // ),
//             ,  SizedBox(
//                 height: SizesConstant.spaceBtwSection * 2,
//               ),
//             ],
//           ),
//         ),
//       ),
    );
  }
}
