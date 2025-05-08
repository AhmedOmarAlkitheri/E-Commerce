import 'package:ecommerce_app_client/Core/View/order/widget/orderListItem.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(
        title: Text(
          "طلباتي",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
              onPressed: () {        Get.offAllNamed("/Navigationmenu");
            
              
              },
              icon: Icon(Icons.arrow_forward_ios_rounded))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(SizesConstant.defaultSpace),
        child: OrderListItem(),
      ),
    );
  }
}
