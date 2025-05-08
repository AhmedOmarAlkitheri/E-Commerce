import 'package:ecommerce_app_client/Core/View/address/addNewAddressScreen/addNewAddressScreen.dart';
import 'package:ecommerce_app_client/Core/View/address/widget/singleAddress.dart';
import 'package:ecommerce_app_client/Core/ViewModel/address/addressVM.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/FirebaseStorageService.dart';
import 'package:ecommerce_app_client/global/widgets/appBar/customAppbar.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(AddressVM());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () =>    Get.toNamed("/AddNewAddressScreen"),
        child: const Icon(Icons.add, color: AppColor.white),
      ), // FloatingActionButton
      appBar: Customappbar(
        showBackArrow: true,
        onPressed: ()=>  Get.offNamed("/Navigationmenu") ,
        title:
            Text('العناوين', style: Theme.of(context).textTheme.headlineSmall),
      ), // TAppBar
      body:

 SingleChildScrollView(
    child: Padding( 
    padding:  EdgeInsets.all(SizesConstant.defaultSpace),
    child: Obx(
    () => FutureBuilder(
    // Use key to trigger refresh

    key: Key(controller.refreshData.value.toString()),
    future: controller.getAllUserAddressesSupabase(),
    builder: (context, snapshot) {
    // Helper Function: Handle Loader, No Record, OR ERROR Message
    final response = FirebaseStorageService.checkMultiRecordState(snapshot: snapshot);
    if (response != null) return response;
    final addresses = snapshot.data;
    return ListView.builder(
    shrinkWrap: true,
    itemCount: addresses!.length,
    itemBuilder: (_, index) => SingleAddress(
    address: addresses[index],
    onTap: () => controller.selectAddressSupabase(addresses[index]),
    ),
    );
    }
    ),
    )
 ))
    );
  }
}
