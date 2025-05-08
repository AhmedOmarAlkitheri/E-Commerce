import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_client/Core/Model/productModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/productVM/productVM.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/FirebaseStorageService.dart';
import 'package:ecommerce_app_client/global/widgets/Layout/gridLayout.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/sortableProduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/widgets/product_card/productCardVertical.dart';
import '../../../global/widgets/shimmer/verticalProductShimmer.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Productvm());

    return Scaffold(
      // AppBar
      appBar: Customappbar(
        title: Text(title),
        showBackArrow: true,
        onPressed: () => Get.offNamed("/Navigationmenu"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuerys(query!),
            builder: (context, snapshot) {
              // Check the state of the FutureBuilder snapshot
              const loader = VerticalProductShimmer();
              final widget = FirebaseStorageService.checkMultiRecordState(
                  snapshot: snapshot, loader: loader);
              // Return appropriate widget based on snapshot state
              if (widget != null) return widget;
              // Products found!
              final products = snapshot.data!;

              return SortableProducts(products: products);
            }, // FutureBuilder
          ), // Padding
        ), // SingleChildScrollView
      ), // Scaffold
    );
  }
}
