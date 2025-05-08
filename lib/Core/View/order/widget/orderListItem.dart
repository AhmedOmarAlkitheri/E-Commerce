import 'package:ecommerce_app_client/Core/View/order/widget/customOrderWidget.dart';
import 'package:ecommerce_app_client/Core/ViewModel/orderVM/orderVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/FirebaseStorageService.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/loader/animationLoaderWidget.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:ecommerce_app_client/global/widgets/roundedContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Helperfunction.isDarkMode(context);
    final controller = Get.put(OrderVM());
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          // Nothing Found Widget
          final emptyWidget = AnimationLoaderWidget(
              text: 'Whoops! No Orders Yet!',
              animation: ImagesConstant.successfully_done,
              showAction: true,
              actionText: 'Let\'s fill it',
              onActionPressed: () =>
                  Get.offNamed("/Navigationmenu")); // TAnimationLoaderWidget

          // Helper Function: Handle Loader, No Record, OR ERROR Message
          final response = FirebaseStorageService.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          // Congratulations 🟢 Record found.
          final orders = snapshot.data;
          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders!.length,
              separatorBuilder: (_, index) =>
                  SizedBox(height: SizesConstant.spaceBtwItem),
              itemBuilder: (_, index) {
                final order = orders[index];

                return RoundedContainer(
                  showBorder: true,
                  backgroundColor: dark ? AppColor.dark : AppColor.light,
                  padding: EdgeInsets.all(SizesConstant.md),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          CustomOrderWidget(
                              icon: Icons.open_with_sharp,
                              titleStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                      color: AppColor.primary,
                                      fontWeightDelta: 1),
                              subTitleStyle:
                                  Theme.of(context).textTheme.headlineSmall,
                              title: order.orderStatusText ?? "", 
                              subTitle:order.formattedOrderDate ?? ''
                              ),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                      SizedBox(
                        height: SizesConstant.spaceBtwItem,
                      ),
                      Row(
                        children: [
                          CustomOrderWidget(
                              icon: Icons.open_with_sharp,
                              titleStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              subTitleStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              title: "الطلبية",
                              subTitle: order.id ?? '',
                              ),
                          CustomOrderWidget(
                              icon: Icons.open_with_sharp,
                              titleStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              subTitleStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              title: "تاريخ الشراء",
                              subTitle: order.formattedDeliveryDate ?? ''
                              ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
