import 'package:ecommerce_app_client/Core/Model/productModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/productVM/productVM.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/Layout/gridLayout.dart';
import 'package:ecommerce_app_client/global/widgets/product_card/productCardVertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortableProducts extends StatelessWidget {
  const SortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product sorting
    final controller = Get.put(Productvm());

    controller.assignProducts(products);

    return Obx(
      () => Column(
        children: [
          // Dropdown
          DropdownButtonFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.sort)),
            value: controller.selectedSortOption.value,
            onChanged: (value) {
              // Sort products based on the selected option
              controller.sortProducts(value!);
            },
            items: [
              'Name',
              'Higher Price',
              'Lower Price',
              'Sale',
              'Newest',
              'Popularity'
            ]
                .map((option) =>
                    DropdownMenuItem(value: option, child: Text(option)))
                .toList(),
          ),
          SizedBox(height: SizesConstant.spaceBtwSection),
          // Products
          GridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                ProductCardVertical(product: controller.products[index]),
          )
        ], // Column
      ),
    );
  }
}











// class SortableProducts extends StatelessWidget {
//   const SortableProducts({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Dropdown
//         DropdownButtonFormField(
//           decoration: const InputDecoration(prefixIcon: Icon(Icons.sort)),
//           onChanged: (value) {},
//           items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
//               .map((option) => DropdownMenuItem(
//                     value: option,
//                     child: Text(option),
//                   ))
//               .toList(),
//         ), // DropdownButtonFormField
//          SizedBox(height: SizesConstant.spaceBtwSection),
//         // Products
//         GridLayout(
//           itemCount: 8,
//           itemBuilder: (_, index) => const ProductCardVertical(),
//         ),
//       ],
//     ); // Column
//   }
// }