import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_client/Core/Model/orderModel.dart';
import 'package:ecommerce_app_client/Core/View/successScreen.dart/successScreen.dart';
import 'package:ecommerce_app_client/Core/ViewModel/address/addressVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/cartVM/cartVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/checkoutController.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/enum.dart';
import 'package:ecommerce_app_client/global/loader/fullScreenLoader.dart';
import 'package:ecommerce_app_client/global/loader/loader.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderVM extends GetxController {
  final cartController = CartVM.instance;
  final addressController = AddressVM.instance;
  final checkoutController = CheckoutController.instance;
  final _auth = FirebaseAuth.instance;

  final _db = FirebaseFirestore.instance;

/* --- FUNCTIONS --- */

  /// Get all order related to current User
  Future<List<OrderModel>> fetchUserOrder() async {
    try {
      final userId = _auth.currentUser!.uid;
      if (userId.isEmpty)
        throw 'Unable to find user information. Try again in few minutes.';

      final result =
          await _db.collection('users').doc(userId).collection('Orders').get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching Order Information. Try again later';
    }
  }

  /// Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving Order Information. Try again later';
    }
  }

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await fetchUserOrder();
      return userOrders;
    } catch (e) {
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      FullScreenLoader.openLoadingDialog(
          'Processing your order', ImagesConstant.successfully_done);
      // Get user authentication Id
      final userId = _auth.currentUser!.uid;
      if (userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
        // Generate a unique ID for the order
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        // Set Date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      ); // OrderModel

      // Save the order to Firestore
      await saveOrder(order, userId);

      // Update the cart status
      cartController.clearCart();

      // Show Success screen
      Get.off(() => Successscreen(
          image: ImagesConstant.successfully_done,
          title: 'Payment Success!',
          subTitle: 'Your item will be shipped soon!',
          onPressed: () => Get.offAllNamed("/Navigationmenu")));
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
