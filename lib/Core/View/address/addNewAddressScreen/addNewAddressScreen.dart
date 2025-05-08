import 'package:ecommerce_app_client/Core/ViewModel/address/addressVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressVM());

    return Scaffold(
      appBar: Customappbar(
        showBackArrow: true,
        title: Text('إضافة عنوان جديد'),
        onPressed: () => Get.offNamed("/UserAddressScreen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConstant.defaultSpace),
          child: Form(
            key: controller.addressFromKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  decoration: InputDecoration(
                    prefixIcon: Transform.scale(
                      scale: 0.5,
                      child: Image.asset(ImagesConstant.profile,
                          height: SizesConstant.iconSm,
                          color: AppColor.greyIcon),
                    ),
                    labelText: 'الاسم',
                  ),
                ),
                SizedBox(height: SizesConstant.spaceBtwInputField),
                TextFormField(
                    controller: controller.phoneNumber,
                    decoration: InputDecoration(
                        prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: Image.asset(
                            ImagesConstant.phone_book,
                            height: SizesConstant.iconSm,
                            color: AppColor.greyIcon,
                          ),
                        ),
                        labelText: 'رقم الجوال')),
                SizedBox(height: SizesConstant.spaceBtwInputField),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            controller: controller.street,
                            decoration: InputDecoration(
                                prefixIcon: Transform.scale(
                                  scale: 0.5,
                                  child: Image.asset(
                                    ImagesConstant.map_street,
                                    height: SizesConstant.iconSm,
                                    color: AppColor.greyIcon,
                                  ),
                                ),
                                labelText: 'الشارع'))),
                    SizedBox(width: SizesConstant.spaceBtwInputField),
                    Expanded(
                        child: TextFormField(
                            controller: controller.postalCode,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.image,
                                ),
                                labelText: 'Postal Code'))),
                  ], // Row
                ),
                SizedBox(height: SizesConstant.spaceBtwInputField),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            controller: controller.city,
                            decoration: InputDecoration(
                                prefixIcon: Transform.scale(
                                  scale: 0.5,
                                  child: Image.asset(
                                    ImagesConstant.skyscrapper,
                                    height: SizesConstant.iconSm,
                                    color: AppColor.greyIcon,
                                  ),
                                ),
                                labelText: 'المدينة'))),
                    SizedBox(width: SizesConstant.spaceBtwInputField),
                    Expanded(
                        child: TextFormField(
                            controller: controller.state,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.image),
                                labelText: 'المحافظة'))),
                  ], // Row
                ),
                SizedBox(height: SizesConstant.spaceBtwInputField),
                TextFormField(
                    controller: controller.country,
                    decoration: InputDecoration(
                        prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: Image.asset(
                            ImagesConstant.worldwide,
                            color: AppColor.greyIcon,
                            height: SizesConstant.iconSm,
                          ),
                        ),
                        labelText: 'البلد')),
                SizedBox(height: SizesConstant.defaultSpace),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.addNewAddressesSupabase();
                          //   Get.offAllNamed("/UserAddressScreen");
                        },
                        child: Text("حفظ"))),
              ], // Column
            ), // Form
          ), // Padding
        ), // SingleChildScrollView
      ), // Scaffold
    );
  }
}
