import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ecommerce_app_client/global/constants/enum.dart';
import 'package:ecommerce_app_client/global/loader/loader.dart';
import 'package:ecommerce_app_client/helper/Exceptions/supabaseException.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../helper/Exceptions/firebaseException.dart';
import '../../../helper/Exceptions/formatException.dart';
import '../../../helper/Exceptions/platformException.dart';
import '../../../helper/dioHelper.dart';
import '../../Model/productModel.dart';

class Productvm extends GetxController {
  static Productvm get instance => Get.find();

  /// Firestore instance for database interactions.
  final _db = FirebaseFirestore.instance;
  SupabaseClient client = Supabase.instance.client;
  final isLoading = false.obs;
  final DioHelper _dioHelper = DioHelper.instance;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  @override
  void onInit() {
    //   fetchFeaturedProducts();
    fetchFeaturedProductsSupabase();
    super.onInit();
  }

  Productvm() {
    // fetchFeaturedProducts();
    // getAllFeaturedProducts();
  }

/*

    final response = await _supabase
        .rpc('get_all_product')
        .execute();
*/

  Future<List<ProductModel>> fetchFeaturedProductSupabase() async {
    try {
      // dio.Options? headers = dio.Options();
      // headers.headers = {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      // };
      Map<String, dynamic> data = {"is_featured": true};
      final response =
          await _dioHelper.postRequest(url: "rpc/get_all_products", data: data);
// option: headers,
      //  final List<dynamic> dataProduct = response.data;
      print(response.data);
      if (response.data is List) {
        List<dynamic> product = response.data;

        return product.map((e) => ProductModel.fromJsonSupabase(e)).toList();
      } else {
        throw Exception("Expected a list but got ${response.data.runtimeType}");
      }
    } on AuthException catch (e) {
      throw SupabaseExcept("خطاء", e.message);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  void fetchFeaturedProductsSupabase() async {
    try {
      // Show loader while loading Products
      isLoading.value = true;

      // Fetch Products
      final product = await fetchFeaturedProductSupabase();

      products.assignAll(product);

      // Assign Products
      featuredProducts.assignAll(product);
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

      // Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getFavouriteProductsSupabase(
      List<String> productIds) async {
    try {
    

      Map<String, dynamic> data = {'product_ids': productIds};
      final response =
          await _dioHelper.postRequest(url: "rpc/get_products_by_ids", data: data);

      if (response.data is List) {
        List<dynamic> productList = response.data;

        return productList
            .map((e) => ProductModel.fromJsonSupabase(e))
            .toList();
      } else {
        throw Exception("Expected a list but got ${response.data.runtimeType}");
      }
    } catch (e) {
      throw 'حدث خطأ ما. حاول مرة أخرى';
    }
  }
//-------------------------------------------------------------------------------------------------

  /// Get all featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('products')
          .where('IsFeatured', isEqualTo: true)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
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

  // Get Products based on the Query
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
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

// Get Products based on the Query
  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
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

  void fetchFeaturedProducts() async {
    try {
      // Show loader while loading Products
      isLoading.value = true;

      // Fetch Products
      final product = await getAllFeaturedProducts();

      products.assignAll(product);

      // Assign Products
      featuredProducts.assignAll(product);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Future<List<ProductModel>> fetchAllFeaturedProducts() async {
  //   try {
  //     // // Show loader while loading Products
  //     // isLoading.value = true;

  //     // Fetch Products
  //     final product = await getAllFeaturedProducts();
  //     // products.assignAll(product);
  //     return product;
  //   } catch (e) {
  //     Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  //     return [];
  //   }
  //   // } finally {
  //   //   isLoading.value = false;
  //   // }
  // }

  Future<List<ProductModel>> fetchProductsByQuerys(Query? query) async {
    try {
      if (query == null) return [];
      final products = await fetchProductsByQuery(query);
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title!.compareTo(b.title!));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price!.compareTo(a.price!));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price!.compareTo(b.price!));
        break;
      case 'Newest':
        products.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      case 'Sale':
        products.sort((a, b) {
          if (b.salePrice! > 0) {
            return b.salePrice!.compareTo(a.salePrice!);
          } else if (a.salePrice! > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      default:
        // Default sorting option: Name
        products.sort((a, b) => a.title!.compareTo(b.title!));
    }
  }

  void assignProducts(List<ProductModel> products) {
    // Assign products to the 'products' list
    this.products.assignAll(products);
    sortProducts('Name');
  }

  /// -- Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// -- Check Product Stock Status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variations exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice! > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      // Calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        // Determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider = variation.salePrice! > 0.0
            ? variation.salePrice!
            : variation.price!;

        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // If smallest and largest prices are the same, return a single price
      if (smallestPrice == largestPrice) {
        return largestPrice.toString();
      } else {
        // Otherwise, return a price range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }
}











  // /// Get limited featured products
  // Future<List<ProductModel>> getFeaturedProducts() async {
  //   try {
  //     final snapshot = await _db
  //         .collection('products')
  //         .where('IsFeatured', isEqualTo: true)
  //         //  .limit(4)
  //         .get();
  //     // products.assignAll(
  //     //     snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList());
  //     // print(
  //     //     "ahmed ${snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList()}");
  //     return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
  //   } on FirebaseException catch (e) {
  //     throw FirebaseExcept(e.code, e.message);
  //   } on FormatException catch (_) {
  //     throw FormatExcept();
  //   } on PlatformException catch (e) {
  //     throw PlatformExcept(e.code, e.message);
  //   } catch (e) {
  //     throw 'حدث خطأ ما . حاول مرة اخرى';
  //   }
  // }