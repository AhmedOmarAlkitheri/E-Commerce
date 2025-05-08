import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_client/Core/Model/brandModel.dart';
import 'package:ecommerce_app_client/Core/Model/categories.dart';
import 'package:ecommerce_app_client/Core/Model/productModel.dart';
import 'package:ecommerce_app_client/helper/Exceptions/firebaseAuthException.dart';
import 'package:ecommerce_app_client/helper/Exceptions/formatException.dart';
import 'package:ecommerce_app_client/helper/dioHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../global/loader/loader.dart';
import '../../../helper/Exceptions/firebaseException.dart';
import '../../../helper/Exceptions/platformException.dart';
import '../../../helper/Exceptions/supabaseException.dart';

class CategoryViewModel extends GetxController {
  static CategoryViewModel get instance => Get.find();

  final DioHelper _dioHelper = DioHelper.instance;
  final RxList<CategoryModel> categorymodel = <CategoryModel>[].obs;
  SupabaseClient client = Supabase.instance.client;
  final isLoading = false.obs;

  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    //   fetchCategories();
    fetchAllCategorys();
    super.onInit();
  }

  Future<List<CategoryModel>> fetchAllCategory() async {
    try {
      final response = await _dioHelper.getRequest(url: "categories");

      if (response.data is List) {
        List<dynamic> data = response.data;

        return data.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        throw "البيانات ليست من نوع list بسبب ${response.data.runtimeType}";
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

  Future<void> fetchAllCategorys() async {
    try {
      isLoading.value = true;

      final categories = await fetchAllCategory();

      categorymodel.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(categorymodel
          .where(
              (category) => category.isFeatured! && category.parentId!.isEmpty)
          // .take(2)
          .toList());
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

  Future<List<ProductModel>> getCategoryProductsSupabase(
      {required String categoryId, int limit = 4}) async {
    try {
      // Fetch limited (4) products against each subCategory;
      final products = await getProductsForCategorySupabase(
          categoryId: categoryId, limit: limit);

      return products;
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
      return [];
    }
  }

  Future<List<ProductModel>> getProductsForCategorySupabase(
      {required String categoryId, int limit = 4}) async {
    try {
      final brandCategoryResponse = limit == -1
          ? await client
              .from('productCategory')
              .select('product_id')
              .eq('category_id', categoryId)
          : await client
              .from('productCategory')
              .select('product_id')
              .eq('category_id', categoryId)
              .limit(limit);

      // تحويل النتائج إلى قائمة من brandIds
      final List<String> productIds = (brandCategoryResponse as List)
          .map((item) => item['product_id'] as String)
          .toList();

      final brandsResponse = await client
          .from('products')
          .select()
          .inFilter('product_id', productIds);

      List<ProductModel> products = (brandsResponse as List)
          .map((item) => ProductModel.fromJsonSupabase(item))
          .toList();

      return products;
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

  Future<List<CategoryModel>> getSubCategorieSupabase(String categoryId) async {
    try {
      final response =
          await client.from('categories').select().eq('parentId', categoryId);
      final result = response.map((e) => CategoryModel.fromJson(e)).toList();
      return result;
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

// Load selected category data
  Future<List<CategoryModel>> getSubCategoriesSupabase(
      String categoryId) async {
    try {
      final subCategories = await getSubCategorieSupabase(categoryId);
      return subCategories;
    } catch (e) {
      if (e is SupabaseExcept) {
        Loaders.errorSnackBar(title: 'خطاء', message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "خطاء", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "خطاء", message: e.toString());
      }
      return [];
    }
  }

//------------------------------------------

// // Get all categories
//   Future<List<CategoryModel>> getAllCategories() async {
//     try {
//       final snapshot = await _db.collection('categories').get();

//       final list = snapshot.docs
//           .map((document) => CategoryModel.fromSnapshot(document))
//           .toList();

//       return list;
//     } on FirebaseAuthExcept catch (e) {
//       throw FirebaseAuthExcept(e.code).message;
//     } on FirebaseException catch (e) {
//       throw FirebaseExcept(e.code).message;
//     } on PlatformException catch (e) {
//       throw PlatformExcept(e.code).message;
//     } catch (e) {
//       throw 'حدث خطأ ما . حاول مرة اخرى';
//     }
//   }

//   /// -- Load category data
//   Future<void> fetchCategories() async {
//     try {
//       // Show loader while loading categories
//       isLoading.value = true;

//       // Fetch categories from data source (Firestore, API, etc.)
//       final categories = await getAllCategories();

//       // Update the categories list
//       categorymodel.assignAll(categories);

//       // Filter featured categories
//       featuredCategories.assignAll(categorymodel
//           .where(
//               (category) => category.isFeatured! && category.parentId!.isEmpty)
//           // .take(2)
//           .toList());
//     } catch (e) {
//       if (e is FirebaseAuthExcept) {
//         Loaders.errorSnackBar(title: e.code, message: e.message);
//       } else if (e is FirebaseExcept) {
//         Loaders.errorSnackBar(title: e.code, message: e.message);
//       } else if (e is PlatformExcept) {
//         Loaders.errorSnackBar(title: e.code, message: e.message);
//       } else if (e is FormatExcept) {
//         Loaders.errorSnackBar(title: "حدث خطاء ما !!", message: e.message);
//       } else {
//         Loaders.warningSnackBar(
//           title: "حدث خطاء ما !!",
//           message: e.toString(),
//         );
//       }
//     } finally {
//       // Remove Loader
//       isLoading.value = false;
//     }
//   }

// // Get Category or Sub-Category Products.
//   Future<List<ProductModel>> getCategoryProducts(
//       {required String categoryId, int limit = 4}) async {
//     try {
//       // Fetch limited (4) products against each subCategory;
//       final products =
//           await getProductsForCategory(categoryId: categoryId, limit: limit);

//       return products;
//     } catch (e) {
//       if (e is FirebaseAuthExcept) {
//         Loaders.errorSnackBar(title: e.code, message: e.message);
//       } else if (e is FirebaseExcept) {
//         Loaders.errorSnackBar(title: e.code, message: e.message);
//       } else if (e is PlatformExcept) {
//         Loaders.errorSnackBar(title: e.code, message: e.message);
//       } else if (e is FormatExcept) {
//         Loaders.errorSnackBar(title: "حدث خطاء ما !!", message: e.message);
//       } else {
//         Loaders.warningSnackBar(
//           title: "حدث خطاء ما !!",
//           message: e.toString(),
//         );
//       }
//       return [];
//     }
//   }

//   /// Get Sub Categories
//   Future<List<CategoryModel>> getSubCategorie(String categoryId) async {
//     try {
//       final snapshot = await _db
//           .collection("categories")
//           .where('parentId', isEqualTo: categoryId) //ParentId
//           .get();
//       final result =
//           snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
//       return result;
//     } on FirebaseException catch (e) {
//       throw FirebaseExcept(e.code, e.message);
//     } on FormatException catch (_) {
//       throw FormatExcept();
//     } on PlatformException catch (e) {
//       throw PlatformExcept(e.code, e.message);
//     } catch (e) {
//       throw 'حدث خطأ ما . حاول مرة اخرى';
//     }
//   }

// // Load selected category data
//   Future<List<CategoryModel>> getSubCategories(String categoryId) async {
//     try {
//       final subCategories = await getSubCategorie(categoryId);
//       return subCategories;
//     } catch (e) {
//       if (e is FirebaseAuthExcept) {
//         Loaders.errorSnackBar(title: e.code, message: e.message);
//       } else if (e is FirebaseExcept) {
//         Loaders.errorSnackBar(title: e.code, message: e.message);
//       } else if (e is PlatformExcept) {
//         Loaders.errorSnackBar(title: e.code, message: e.message);
//       } else if (e is FormatExcept) {
//         Loaders.errorSnackBar(title: "حدث خطاء ما !!", message: e.message);
//       } else {
//         Loaders.warningSnackBar(
//           title: "حدث خطاء ما !!",
//           message: e.toString(),
//         );
//       }
//       return [];
//     }
//   }

//   Future<List<ProductModel>> getProductsForCategory(
//       {required String categoryId, int limit = 4}) async {
//     try {
//       // Query to get all documents where productId matches the provided categoryId & Fetch limited or unlimited based on limit
//       QuerySnapshot productCategoryQuery = limit == -1
//           ? await _db
//               .collection('productCategory')
//               .where('category_id', isEqualTo: categoryId)
//               .get()
//           : await _db
//               .collection('productCategory')
//               .where('category_id', isEqualTo: categoryId)
//               .limit(limit)
//               .get();

//       // Extract productIds from the documents
//       List<String> productIds = productCategoryQuery.docs
//           .map((doc) => doc['product_id'] as String)
//           .toList();

//       // Query to get all documents where the productId is in the list of productIds, FieldPath.documentId to query documents in Collection
//       final productsQuery = await _db
//           .collection('products')
//           .where(FieldPath.documentId, whereIn: productIds)
//           .get();

//       // Extract product names or other relevant data from the documents
//       List<ProductModel> products = productsQuery.docs
//           .map((doc) => ProductModel.fromSnapshot(doc))
//           .toList();

//       return products;
//     } on FirebaseAuthException catch (e) {
//       throw FirebaseAuthExcept(e.code, e.message);
//     } on FirebaseException catch (e) {
//       throw FirebaseExcept(e.code, e.message);
//     } on FormatException catch (_) {
//       throw FormatExcept();
//     } on PlatformException catch (e) {
//       throw PlatformExcept(e.code, e.message);
//     } catch (e) {
//       throw 'حدث خطأ ما . حاول مرة اخرى';
//     }
//   }
// }
//   // Future<String> fetchAllCategory() async {
//   //   try {
//   //     isLoading.value = true;
//   //     final response = await _dioHelper.getRequest(url: "categories");
//   //     final List<dynamic> data = response.data;
//   //     categorymodel
//   //         .assignAll(data.map((e) => CategoryModel.fromJson(e)).toList());

//   //     isLoading.value = false;
//   //     return "seccuss";
//   //   } catch (e) {
//   //     return "Error fetching Slider Banner: $e";
//   //   }
//   // }

// // Future<List<ProductModel>> getCategorysForProducts({required String categoryId, int limit = -1}) async {
// //     try {
// //         final querySnapshot = limit == -1
// //             ? await _db.collection('brandCategory').where('category_id', isEqualTo: categoryId).get()
// //             : await _db.collection('brandCategory').where('category_id', isEqualTo: categoryId).limit(limit).get();

// //         final products = querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

// //         return products;
// //    } on FirebaseException catch (e) {
// //       throw FirebaseExcept(e.code, e.message);
// //     } on FormatException catch (_) {
// //       throw FormatExcept();
// //     } on PlatformException catch (e) {
// //       throw PlatformExcept(e.code, e.message);
// //     } catch (e) {
// //       throw 'حدث خطأ ما . حاول مرة اخرى';
// //     }
// // }

// // // Get Brand Specific Products from your data source
// // Future<List<ProductModel>> getCategoryProducts(String categoryId) async {
// //     try {

// //         final brand = await getCategorysForProducts(categoryId: categoryId);
// //         return brand;
// //     } catch (e) {
// //         Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
// //         return [];
// //     }
// // }
}
