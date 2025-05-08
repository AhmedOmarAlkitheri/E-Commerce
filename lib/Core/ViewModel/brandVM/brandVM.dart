import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_client/Core/Model/brandModel.dart';
import 'package:ecommerce_app_client/helper/Exceptions/firebaseException.dart';
import 'package:ecommerce_app_client/helper/Exceptions/formatException.dart';
import 'package:ecommerce_app_client/helper/dioHelper.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../global/loader/loader.dart';
import '../../../helper/Exceptions/platformException.dart';
import '../../../helper/Exceptions/supabaseException.dart';
import '../../Model/productModel.dart';

class BrandViewModel extends GetxController {
  final DioHelper _dioHelper = DioHelper.instance;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final _db = FirebaseFirestore.instance;
  RxBool isLoading = true.obs;

  static BrandViewModel get instance => Get.find();

  SupabaseClient client = Supabase.instance.client;

  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  BrandViewModel();

  @override
  void onInit() {
    // getFeaturedBrands();
    fetchAllBrands();
    super.onInit();
  }

  // Future<String> fetchAllBrands() async {
  //   try {
  //     final response = await _dioHelper.getRequest(url: "brands");
  //     final List<dynamic> data = response.data;
  //     allBrands.assignAll(data.map((e) => BrandModel.fromJson(e)).toList());
  //     return "seccuss";
  //   } catch (e) {
  //     return "Error fetching brands: $e";
  //   }
  // }

  Future<List<BrandModel>> fetchAllBrand() async {
    try {
      bool isFeatured = true;
      final response = await _dioHelper.getRequest(
        url: "brands",
        queryParameters: {'isFeatured': 'eq.$isFeatured'},
      );

      if (response.data is List) {
        List<dynamic> data = response.data;

        return data.map((e) => BrandModel.fromJsonSupabase(e)).toList();
      } else {
        throw Exception(
            "البيانات ليست من نوع list بسبب ${response.data.runtimeType}");
      }
    } on AuthException catch (e) {
      throw SupabaseExcept("خطاء", e.message);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw "Error fetching Brand : $e";
    }
  }

  Future<void> fetchAllBrands() async {
    try {
      isLoading.value = true;

      final data = await fetchAllBrand();

      allBrands.assignAll(data);
      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(1));
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

  /// Get Brands For Category
  Future<List<BrandModel>> getBrandsForCategorySupabase(
      String categoryId) async {
    try {
      final brandCategoryResponse =
          //await    client
          // .from('brandCategory')
          // .select('brand_id')
          // .eq('category_id', categoryId);

          await _dioHelper.postRequest(
        url: "brandCategory",
        queryParameters: {
          'category_id': 'eq.$categoryId',
        },
      
      );

      // تحويل النتائج إلى قائمة من brandIds
      final List<String> brandIds = (brandCategoryResponse as List)
          .map((item) => item['brand_id'] as String)
          .toList();

      final brandsResponse = await client
          .from('brands')
          .select()
          .inFilter('brand_id', brandIds)
          .limit(2);

      // تحويل النتائج إلى List<BrandModel>
      final List<BrandModel> brands = (brandsResponse as List)
          .map((item) => BrandModel.fromJsonSupabase(item))
          .toList();

      return brands;
    } on AuthException catch (e) {
      throw SupabaseExcept("خطاء", e.message);
    } on FormatException catch (_) {
      throw FormatExcept();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw 'حدث خطأ ما. حاول مرة أخرى';
    }
  }

// Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProductsSupabase(
      {required String brandId, int limit = -1}) async {
    try {
      final products =
          await getProductsForBrandSupabase(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getProductsForBrandSupabase(
      {required String brandId, int limit = -1}) async {
    try {
      final response = limit == -1
          ? await _dioHelper.postRequest(
              url: "products",
              queryParameters: {
                'brand_id': 'eq.$brandId',
              },
            )

          //      await   client
          // .from('products')
          // .select()
          // .eq('brand_id', brandId)

          : await _dioHelper.postRequest(
              url: "products",
              queryParameters: {
                'brand_id': 'eq.$brandId',
                'limit': limit,
              },
            );

// await client
//               .from('products')
//               .select()
//               .eq('brand_id', brandId)
//               .limit(limit);

      final products = (response as List)
          .map((doc) => ProductModel.fromJsonSupabase(doc))
          .toList();

      return products;
    } on AuthException catch (e) {
      throw SupabaseExcept("خطاء", e.message);
    } on FormatException catch (_) {
      throw FormatExcept();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw 'حدث خطأ ما . حاول مرة اخرى';
    }
  }

//---------------------------------------------------------------

// /// Set all order related to current User
// Future<List<BrandModel>> fetchBrand() async {
//     try {
//         final result = await _db.collection('brands').where('isFeatured', isEqualTo: true).get();
//         return result.docs.map((documentSnapshot) => BrandModel.fromSnapshot(documentSnapshot)).toList();
//         } on FirebaseException catch (e) {
//       throw FirebaseExcept(e.code, e.message);
//     } on FormatException catch (_) {
//       throw FormatExcept();
//     } on PlatformException catch (e) {
//       throw PlatformExcept(e.code, e.message);
//     } catch (e) {
//       throw 'حدث خطأ ما . حاول مرة اخرى';
//     }
// }

//     /// -- Load Brands
//     Future<void> getFeaturedBrands() async {
//         try {
//             // Show loader while loading Brands
//             isLoading.value = true;

//             final brands = await fetchBrand();

//             allBrands.assignAll(brands);

//             featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));

//         } catch (e) {
//             Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//         } finally {
//             // Stop loader
//             isLoading.value = false;
//         }
//     }

// // Get Brand Specific Products from your data source
// Future<List<ProductModel>> getBrandProducts({required String brandId , int limit = -1}) async {
//     try {
//         final products = await getProductsForBrand(brandId: brandId , limit:  limit);
//         return products;
//     } catch (e) {
//         Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//         return [];
//     }
// }

// /// Get Brands For Category
// Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
//     try {
//         // Query to get all documents where categoryId matches the provided categoryId
//         QuerySnapshot brandCategoryQuery = await _db.collection('brandCategory').where('category_id', isEqualTo: categoryId).get();
//         // Extract brandIds from the documents
//         List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brand_id'] as String).toList();
//         // Query to get all documents where the brandId is in the list of brandIds, FieldPath.documentId to query documents in Collection
//         final brandsQuery = await _db.collection('brands').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();
//         // Extract brand names or other relevant data from the documents
//         List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
//         return brands;
//    } on FirebaseException catch (e) {
//       throw FirebaseExcept(e.code, e.message);
//     } on FormatException catch (_) {
//       throw FormatExcept();
//     } on PlatformException catch (e) {
//       throw PlatformExcept(e.code, e.message);
//     } catch (e) {
//       throw 'حدث خطأ ما . حاول مرة اخرى';
//     }
// }

// Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1}) async {
//     try {
//         final querySnapshot = limit == -1
//             ? await _db.collection('products').where('Brand.brand_id', isEqualTo: brandId).get()
//             : await _db.collection('products').where('Brand.brand_id', isEqualTo: brandId).limit(limit).get();

//         final products = querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

//         return products;
//    } on FirebaseException catch (e) {
//       throw FirebaseExcept(e.code, e.message);
//     } on FormatException catch (_) {
//       throw FormatExcept();
//     } on PlatformException catch (e) {
//       throw PlatformExcept(e.code, e.message);
//     } catch (e) {
//       throw 'حدث خطأ ما . حاول مرة اخرى';
//     }
// }
}
