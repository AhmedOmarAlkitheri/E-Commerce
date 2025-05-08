// Show Addresses ModalBottomSheet at Checkout
import 'package:ecommerce_app_client/Core/View/address/widget/singleAddress.dart';
import 'package:ecommerce_app_client/Core/ViewModel/address/addressVM.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/function/FirebaseStorageService.dart';
import 'package:ecommerce_app_client/global/widgets/text/sectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> selectNewAddressPopup(BuildContext context) {
  final addressvm = AddressVM.instance;
  return showModalBottomSheet(
    context: context,
    builder: (_) => SingleChildScrollView(
      child: Container(
        padding:  EdgeInsets.all(SizesConstant.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
                title: 'Select Address', showActionButton: false),
            FutureBuilder(
              future:addressvm.
               getAllUserAddressesSupabase(),
              builder: (_, snapshot) {
                // Helper Function: Handle Loader, No Record, OR ERROR Message
                final response = FirebaseStorageService.
                checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => SingleAddress(
                      address: snapshot.data![index],
                      onTap: () async {
                        await addressvm.
                         selectAddressSupabase(snapshot.data![index]);
                        Get.back();
                      }),
                );
              },
            ), // FutureBuilder
             SizedBox(height: SizesConstant.defaultSpace
             * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () =>
                   Get.toNamed("/AddNewAddressScreen"),
                  child: const Text('إضافة عنوان جديد'
                  )),
            ), // SizedBox
          ],
        ), // Column
      ),
    ), // Container
  );
}
