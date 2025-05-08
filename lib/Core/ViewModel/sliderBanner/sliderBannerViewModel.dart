import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_client/Core/Model/sliderBannerModel.dart';
import 'package:ecommerce_app_client/helper/Exceptions/firebaseAuthException.dart';
import 'package:ecommerce_app_client/helper/Exceptions/formatException.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:ecommerce_app_client/Core/Model/brandModel.dart';
import 'package:ecommerce_app_client/helper/dioHelper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../global/loader/loader.dart';
import '../../../helper/Exceptions/firebaseException.dart';
import '../../../helper/Exceptions/platformException.dart';
import '../../../helper/Exceptions/supabaseException.dart';

class SliderBannerViewModel extends GetxController {
  final _db = FirebaseFirestore.instance;
  final DioHelper _dioHelper = DioHelper.instance;

  final RxList<sliderBannerModel> allsliderbanner = <sliderBannerModel>[].obs;
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  SupabaseClient client = Supabase.instance.client;
  @override
  onInit() {
    fetchAllSliderBanners();
//  fetchBannersFirebase();
    super.onInit();
  }

  SliderBannerViewModel() {}

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  Future<List<sliderBannerModel>> fetchAllSliderBanner() async {
    try {
      bool is_active = true;
      final response = await client
          .from("slider_banners")
          .select()
          .eq("is_active", is_active);

      // _dioHelper.getRequest(
      //   url: "slider_banners",
      //   queryParameters: {"is_active": 'eq.$is_active'},
      // );

      if (response is List) {
        List<dynamic> data = response;

        return data.map((e) => sliderBannerModel.fromJson(e)).toList();
      } else {
        throw Exception(
            "البيانات ليست من نوع list بسبب ${response.runtimeType}");
      }
    } on AuthException catch (e) {
      throw SupabaseExcept("خطاء", e.message);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw "Error fetching Slider Banner: $e";
    }
  }

  Future<void> fetchAllSliderBanners() async {
    try {
      isLoading.value = true;

      final data = await fetchAllSliderBanner();

      allsliderbanner.assignAll(data);
    } catch (e) {
      if (e is SupabaseExcept) {
        Loaders.errorSnackBar(title: 'خطاء', message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

//----------------------------------------

// Get all order related to current User
  Future<List<sliderBannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('slider_banners')
          .where('is_active', isEqualTo: true)
          .get();
      return result.docs
          .map((documentSnapshot) =>
              sliderBannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw FirebaseExcept(e.code, e.message);
    } on FormatException catch (_) {
      throw FormatExcept();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw 'حدث خطأ ما . حاول مرة اخرى';
    }
  }

  /// Fetch Banners
  Future<void> fetchBannersFirebase() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch Banners

      final banners = await fetchBanners();

      // Assign Banners
      this.allsliderbanner.assignAll(banners);
    } catch (e) {
      if (e is FirebaseAuthExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FirebaseExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "حدث خطاء ما !!", message: e.message);
      } else {
        Loaders.warningSnackBar(
          title: "حدث خطاء ما !!",
          message: e.toString(),
        );
      }
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }
}
