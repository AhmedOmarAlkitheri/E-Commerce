import 'dart:convert';

import 'package:ecommerce_app_client/Core/Model/productModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/productVM/productVM.dart';
import 'package:ecommerce_app_client/global/loader/loader.dart';
import 'package:ecommerce_app_client/helper/getstorage_helper.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();
  GetstorageHelper getstorageHelper = GetstorageHelper.instance;

// Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    initFavorites();
    super.onInit();
  }

// Method to initialize favorites by reading from storage
  void initFavorites() {
    final json = getstorageHelper.readFromFile('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      Loaders.customToast(message: 'Product has been added to the WishList.');
    } else {
      getstorageHelper.remove(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      Loaders.customToast(
          message: 'Product has been removed from the WishList.');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    getstorageHelper.writeToFile(key: 'favorites', value: encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {

    print("ahmed omar ${favorites.keys.toList()}");
 print(   getstorageHelper.readFromFile('favorites'));
    return await Productvm.instance.getFavouriteProductsSupabase(favorites.keys.toList());
      //  .getFavouriteProducts(favorites.keys.toList());
  }
}
