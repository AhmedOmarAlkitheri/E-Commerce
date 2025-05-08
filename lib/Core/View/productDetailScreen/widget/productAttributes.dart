import 'package:ecommerce_app_client/Core/Model/productModel.dart';
import 'package:ecommerce_app_client/Core/View/productDetailScreen/widget/choiceChip.dart';
import 'package:ecommerce_app_client/Core/ViewModel/variationController.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:ecommerce_app_client/global/widgets/text/productPriceText.dart';
import 'package:ecommerce_app_client/global/widgets/text/productTitleText.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class customProductAttributes extends StatelessWidget {
  customProductAttributes({super.key, required this.product});
  ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          /// -- Selected Attribute Pricing & Description

          if (controller.selectedVariation.value.id!.isNotEmpty)
            RoundedContainer(
              padding: EdgeInsets.all(SizesConstant.md),
              backgroundColor: dark ? AppColor.darkerGrey : AppColor.grey,
              child: Column(
                children: [
                  // Title, Price and Stock Status
                  Row(
                    children: [
                      const SectionHeading(
                          title: 'Variation', showActionButton: false),
                      SizedBox(width: SizesConstant.spaceBtwItem),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const ProductTitleText(
                                  title: 'Price : ', smallSize: true),
                              // Actual Price
                              if (controller.selectedVariation.value.salePrice! >
                                  0)
                                Text(
                                  '\$${controller.selectedVariation.value.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ), // Text
                              SizedBox(width: SizesConstant.spaceBtwItem),
                              // Sale Price
                              ProductPriceText(
                                  price: controller.getVariationPrice()),
                            ],
                          ), // Row

                          // Stock
                          Row(
                            children: [
                              const ProductTitleText(
                                  title: 'Stock : ', smallSize: true),
                              Text(controller.variationStockStatus.value,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ), // Row
                        ],
                      ), // Column
                    ],
                  ), // Row

                  // Variation Description
                  ProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ), // TProductTitleText
                ],
              ), // Column
            ), // TRoundedContainer

          SizedBox(height: SizesConstant.spaceBtwItem),

          /// -- Attributes
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const SectionHeading(title: 'Colors', showActionButton: false),
          //       SizedBox(height: SizesConstant.spaceBtwItem / 2),
          //  Wrap(
          //           spacing: 8,
          //           children: [
          //             customChoiceChip(
          //                 text: 'Green', selected: false, onSelected: (value) {}),
          //             customChoiceChip(
          //                 text: 'Blue', selected: true, onSelected: (value) {}),
          //             customChoiceChip(
          //                 text: 'Yellow',
          //                 selected: false,
          //                 onSelected: (value) {}),
          //           ],
          //         ),

          //     ],
          //   ), // Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeading(
                            title: attribute.name ?? '',
                            showActionButton: false),
                        SizedBox(height: SizesConstant.spaceBtwItem / 2),
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            children: attribute.values!.map((attributeValue) {
                              final isSelected = controller
                                      .selectedAttributes[attribute.name] ==
                                  attributeValue;
                              final available = controller
                                  .getAttributesAvailabilityInVariation(
                                      product.productVariations!,
                                      attribute.name!)
                                  .contains(attributeValue);
                              return customChoiceChip(
                                  text: attributeValue,
                                  selected: isSelected,
                                  onSelected: available
                                      ? (selected) {
                                          if (selected && available) {
                                            controller.onAttributeSelected(
                                                product,
                                                attribute.name ?? '',
                                                attributeValue);
                                          }
                                        }
                                      : null); // TChoiceChip
                            }).toList(), // Wrap
                          ),
                        ),
                      ],
                    )) // Column
                .toList(),
          ),
        ],
      ),
    ); // Column
  }
}
















   // RoundedContainer(
        //   padding: EdgeInsets.all(SizesConstant.md),
        //   backgroundColor: dark ? AppColor.darkerGrey : AppColor.grey,
        //   child: Column(
        //     children: [
        //       // Title, Price and Stock Status
        //       Row(
        //         children: [
        //           const SectionHeading(
        //               title: 'Variation', showActionButton: false),
        //           SizedBox(width: SizesConstant.spaceBtwItem),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Row(
        //                 children: [
        //                   const ProductTitleText(
        //                       title: 'Price : ', smallSize: true),
        //                   // Actual Price
        //                   Text(
        //                     '\$25',
        //                     style: Theme.of(context)
        //                         .textTheme
        //                         .titleSmall!
        //                         .apply(decoration: TextDecoration.lineThrough),
        //                   ), // Text
        //                   SizedBox(width: SizesConstant.spaceBtwItem),
        //                   // Sale Price
        //                   const ProductPriceText(price: '20'),
        //                 ],
        //               ), // Row
        //             ],
        //           ), // Column
        //         ],
        //       ), // Row

        //       // Stock
        //       Row(
        //         children: [
        //           const ProductTitleText(title: 'Stock : ', smallSize: true),
        //           Text('In Stock',
        //               style: Theme.of(context).textTheme.titleMedium),
        //         ],
        //       ), // Row

        //       // Variation Description
        //       const ProductTitleText(
        //         title:
        //             'This is the Description of the Product and it can go up to max 4 lines.',
        //         smallSize: true,
        //         maxLines: 4,
        //       ), // TProductTitleText
        //     ],
        //   ), // Column
        // ), // TRoundedContainer


         // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const SectionHeading(title: 'Size', showActionButton: false),
        //     SizedBox(height: SizesConstant.spaceBtwItem / 2),
        //     Wrap(
        //       spacing: 8,
        //       children: [
        //         customChoiceChip(
        //             text: 'EU 34', selected: true, onSelected: (value) {}),
        //         customChoiceChip(
        //             text: 'EU 36', selected: false, onSelected: (value) {}),
        //         customChoiceChip(
        //             text: 'EU 38', selected: false, onSelected: (value) {}),
        //       ],
        //     ), // Wrap
        //   ],
        // ), // Column