import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_client/Core/Model/addressModel.dart';
import 'package:ecommerce_app_client/Core/View/address/addNewAddressScreen/addNewAddressScreen.dart';
import 'package:ecommerce_app_client/Core/View/address/userAddressScreen.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/function/networkManager.dart';
import 'package:ecommerce_app_client/global/loader/fullScreenLoader.dart';
import 'package:ecommerce_app_client/helper/getstorage_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../global/constants/apiConstant.dart';
import '../../../global/loader/loader.dart';
import '../../../helper/dioHelper.dart';

class AddressVM extends GetxController {
  static AddressVM get instance => Get.find();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  Rx<bool> refreshData = false.obs;
  GlobalKey<FormState> addressFromKey = GlobalKey<FormState>();
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  GetstorageHelper getstorageHelper = GetstorageHelper.instance;
  SupabaseClient client = Supabase.instance.client;
  final DioHelper _dioHelper = DioHelper.instance;
// Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFromKey.currentState?.reset();
  }

  Future<List<AddressModel>> getAllUserAddressesSupabase() async {
    try {
      final addresses = await fetchUserAddressesSupabase();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress!,
          orElse: () => AddressModel.empty());

      return addresses;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future<List<AddressModel>> fetchUserAddressesSupabase() async {
    try {
      //  final userId = _auth.currentUser!.uid;
      final userId = getstorageHelper.readFromFile("currentUserId") ??
          client.auth.currentUser!.id;

      //   Map<String, dynamic> data = {'user_id': userId};

      final response = await _dioHelper.getRequest(
        url: "Addresses",
        queryParameters: {'user_id': 'eq.$userId'},
      );

      // if (response.data is List) {
      List<dynamic> addressList = response.data;

      return addressList.map((e) => AddressModel.fromJsonSupabase(e)).toList();
      // } else {
      //   throw Exception("Expected a list but got ${response.data.runtimeType}");
      // }

      // final result =
      //     await client.from('Addresses').select().eq('user_id', userId);

      //  return result.map((data) => AddressModel.fromJsonSupabase(data)).toList();
    } catch (e) {
      throw "Something went wrong while fetching Address Information. Try again later $e";
    }
  }

  Future<void> updateSelectedFieldSupabase(
      String addressId, bool selected) async {
    try {
      final userId = getstorageHelper.readFromFile("currentUserId") ??
          client.auth.currentUser!.id;

      await _dioHelper.postRequest(url: "Addresses", queryParameters: {
        'user_id': 'eq.$userId',
        'AddresId': 'eq.$addressId'
      }, data: {
        'SelectedAddress': selected
      });

      // await client
      //     .from('Addresses')
      //     .update({'SelectedAddress': selected})
      //     .eq('user_id', userId)
      //     .eq('AddresId', addressId);
      // .or('and(user_id.eq.$userId, address_id.eq.1)');
    } catch (e) {
      throw "Unable to update your address selection. Try again later";
    }
  }

  Future selectAddressSupabase(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async {
            return false;
          },
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: Loaders.customToast(message: "الله يعين")
          // circularLoader(),

          );

      // Clean the "selected" field
      if (selectedAddress.value.id!.isNotEmpty) {
        await updateSelectedFieldSupabase(selectedAddress.value.id!, false);
      }
      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      // Set the "selected" field to true for the newly selected address
      await updateSelectedFieldSupabase(selectedAddress.value.id!, true);
      Get.back();
    } catch (e) {
      Loaders.errorSnackBar(title: 'Ennon_in_Selection', message: e.toString());
    }
  }

  Future<String> addAddressSupabase(AddressModel address) async {
    try {
      // final userId = getstorageHelper.readFromFile("currentUserId") ??
      //     client.auth.currentUser!.id;
      // final response =
      //     await client
      //     .from('Addresses')
      //     .insert(address.toJsonSupabase())
      //        .select('AddresId')  // تحديد العمود المراد استرجاعه
      //   .single();  // استرجاع سجل واحد فقط

      final response = await _dioHelper.postRequest(
          url: "Addresses",//?select=AddresId
          data: address.toJsonSupabase(),
        
           option: Options(headers: {"Prefer": "return=representation"})
        );//  option: Options(headers: {"Prefer": "return=representation"})
      print("عصاااااااااااااااااااااااااام");
      // if (response.data is List) {
      final insertedAddress =
          response.data[0]; // النتيجة هي قائمة تحتوي على سجل واحد
      return insertedAddress['AddresId'].toString();

      // final insertedAddress = response.data;
      // return insertedAddress['AddresId'].toString();
      // return "09e5d147-d733-495d-11aa-7660137cb9b5";
    } catch (e) {
      throw "Something went wrong while saving Address Information. Try again later $e";
    }
  }

  Future addNewAddressesSupabase() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          'Storing Address...', ImagesConstant.successfully_done);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }
      // Form Validation
      if (!addressFromKey.currentState!.validate()) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }
      // Save Address Data
      final address = AddressModel(
          id: ' ',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          selectedAddress: true,
          user_id: client.auth.currentUser!.id);
      final id = await addAddressSupabase(address);
      print("-------------------++++++----------------------------");
      print(id);
      // Update Selected Address status
      address.id = id;
      await selectAddressSupabase(address);

      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

// Show Success Message
      Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your address has been saved successfully.');

// Refresh Addresses Data
      refreshData.toggle();

// Reset fields
      resetFormFields();

// Redirect
      Get.offNamed("/UserAddressScreen");
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoadingDialog();
      Loaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }
//----------------------------------------------------------------------------

// // fetch all user specific addresses
//   Future<List<AddressModel>> getAllUserAddresses() async {
//     try {
//       final addresses = await fetchUserAddresses();
//       selectedAddress.value = addresses.firstWhere(
//           (element) => element.selectedAddress!,
//           orElse: () => AddressModel.empty());
//       return addresses;
//     } catch (e) {
//       Loaders.errorSnackBar(title: 'Address not found', message: e.toString());
//       return [];
//     }
//   }

// // Add new Address
//   Future addNewAddresses() async {
//     try {
//       // Start Loading
//       FullScreenLoader.openLoadingDialog(
//           'Storing Address...', ImagesConstant.successfully_done);
//       // Check Internet Connectivity
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         FullScreenLoader.stopLoadingDialog();
//         return;
//       }
//       // Form Validation
//       if (!addressFromKey.currentState!.validate()) {
//         FullScreenLoader.stopLoadingDialog();
//         return;
//       }
//       // Save Address Data
//       final address = AddressModel(
//         id: ' ',
//         name: name.text.trim(),
//         phoneNumber: phoneNumber.text.trim(),
//         street: street.text.trim(),
//         city: city.text.trim(),
//         state: state.text.trim(),
//         postalCode: postalCode.text.trim(),
//         country: country.text.trim(),
//         selectedAddress: true,
//       );
//       final id = await addAddress(address);
//       // Update Selected Address status
//       address.id = id;
//       await selectAddress(address);

//       // Remove Loader
//       FullScreenLoader.stopLoadingDialog();

// // Show Success Message
//       Loaders.successSnackBar(
//           title: 'Congratulations',
//           message: 'Your address has been saved successfully.');

// // Refresh Addresses Data
//       refreshData.toggle();

// // Reset fields
//       resetFormFields();

// // Redirect
//       Get.offNamed("/UserAddressScreen");
//     } catch (e) {
//       // Remove Loader
//       FullScreenLoader.stopLoadingDialog();
//       Loaders.errorSnackBar(title: 'Address not found', message: e.toString());
//     }
//   }

//   Future selectAddress(AddressModel newSelectedAddress) async {
//     try {
//       Get.defaultDialog(
//           title: '',
//           onWillPop: () async {
//             return false;
//           },
//           barrierDismissible: false,
//           backgroundColor: Colors.transparent,
//           content: Loaders.customToast(message: "الله يعين")
//           // circularLoader(),

//           );

//       // Clean the "selected" field
//       if (selectedAddress.value.id!.isNotEmpty) {
//         await updateSelectedField(selectedAddress.value.id!, false);
//       }
//       // Assign selected address
//       newSelectedAddress.selectedAddress = true;
//       selectedAddress.value = newSelectedAddress;
//       // Set the "selected" field to true for the newly selected address
//       await updateSelectedField(selectedAddress.value.id!, true);
//       Get.back();
//     } catch (e) {
//       Loaders.errorSnackBar(title: 'Ennon_in_Selection', message: e.toString());
//     }
//   }

//   Future<List<AddressModel>> fetchUserAddresses() async {
//     try {
//       final userId = _auth.currentUser!.uid;
//       // getstorageHelper.readFromFile("currentUserId");
//       if (userId.isEmpty)
//         throw "Unable to find user information. Try again in few minutes.";

//       final result = await _db
//           .collection('users')
//           .doc(userId)
//           .collection('Addresses')
//           .get();

//       return result.docs
//           .map((documentSnapshot) =>
//               AddressModel.fromDocumentSnapshot(documentSnapshot))
//           .toList();
//     } catch (e) {
//       throw "Something went wrong while fetching Address Information. Try again later";
//     }
//   }

//   /// Clear the "selected" field for all addresses
//   Future<void> updateSelectedField(String addressId, bool selected) async {
//     try {
//       final userId = _auth.currentUser!.uid;
//       // final userId =  getstorageHelper.readFromFile("currentUserId");

//       await _db
//           .collection('users')
//           .doc(userId)
//           .collection('Addresses')
//           .doc(addressId)
//           .update({'SelectedAddress': selected});
//     } catch (e) {
//       throw "Unable to update your address selection. Try again later";
//     }
//   }

//   /// Store new user order
//   Future<String> addAddress(AddressModel address) async {
//     try {
//       final userId = _auth.currentUser!.uid;
//       // final userId =  getstorageHelper.readFromFile("currentUserId");
//       final currentAddress = await _db
//           .collection('users')
//           .doc(userId)
//           .collection('Addresses')
//           .add(address.toJson());
//       return currentAddress.id;
//     } catch (e) {
//       throw "Something went wrong while saving Address Information. Try again later";
//     }
//   }
}
