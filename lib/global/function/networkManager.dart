import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../loader/loader.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();

    // حل متوافق مع الإصدارات القديمة التي تعيد List<ConnectivityResult>
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        // إذا كانت `event` قائمة، نأخذ أول قيمة منها
        final  result = event is List<ConnectivityResult> ? event.first : event;
        _updateConnectionStatus(result as ConnectivityResult);
      },
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      Loaders.warningSnackBar(title: 'لا يوجد اتصال بالانترنت');
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } on PlatformException {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
