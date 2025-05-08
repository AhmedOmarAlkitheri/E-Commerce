import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/listNavigatonBar.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:ecommerce_app_client/global/function/navigationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navigationmenu extends StatelessWidget {
  Navigationmenu({super.key, this.selected});
  Rx<int?>? selected;

  final selectIndex = Get.put(Navigationcontroller());

  @override
  Widget build(BuildContext context) {
 
    final dark = Helperfunction.isDarkMode(context);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
        () {
          return Theme(
            data: dark
                ? Theme.of(context).copyWith(
                    iconTheme:
                        IconThemeData(color: AppColor.white.withOpacity(0.8)))
                : Theme.of(context).copyWith(
                    iconTheme:
                        IconThemeData(color: AppColor.black.withOpacity(0.8))),
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: dark ? AppColor.darkerGrey : AppColor.light,
              items: listItems,
              
              height: 60,
              index: selected?.value ?? selectIndex.selectedIndex.value,
              buttonBackgroundColor: AppColor.primary,
              onTap: (index) {
                // if (selected?.value != null) {
                //   // print("${selected?.value}");

                //   selected?.value = selectIndex.selectedIndex.value;
                //   selectIndex.selectedIndex.value = index;
                // } else {
                  selectIndex.selectedIndex.value = index; // تحديث selectIndex
                // }
                // // selected?.value = null;
                // //  print("${selected?.value}");
                // selected = null;
                // selected?.value = null;
                // selectIndex.selectedIndex.value = index;
                // print("$index");
                // print("a ${selectIndex.selectedIndex.value}");
                // print("${selected?.value}");
              },
            ),
          );
        },
      ),
      body: Obx(
        () => ScreensNavigation[//  selected  != null  ?   selected?.value  :
         //   selected?.value ?? 
         selectIndex.selectedIndex.value],
      ),
    );
  }
}
