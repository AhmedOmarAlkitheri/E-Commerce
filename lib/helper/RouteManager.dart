import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_client/Core/Model/brandModel.dart';
import 'package:ecommerce_app_client/Core/Model/categories.dart';
import 'package:ecommerce_app_client/Core/Model/productModel.dart';
import 'package:ecommerce_app_client/Core/View/SplashScreen/SplashScreen.dart';
import 'package:ecommerce_app_client/Core/View/address/addNewAddressScreen/addNewAddressScreen.dart';
import 'package:ecommerce_app_client/Core/View/address/userAddressScreen.dart';
import 'package:ecommerce_app_client/Core/View/allProduct/allProduct.dart';
import 'package:ecommerce_app_client/Core/View/auth/register/register.dart';
import 'package:ecommerce_app_client/Core/View/auth/register/verify_email.dart';
import 'package:ecommerce_app_client/Core/View/auth/forgetPassword/ForgetPasswordScreen.dart';
import 'package:ecommerce_app_client/Core/View/auth/login/login.dart';
import 'package:ecommerce_app_client/Core/View/brand/allBrandsScreen/allBrandsScreen.dart';
import 'package:ecommerce_app_client/Core/View/brand/brandProducts/brandProducts.dart';
import 'package:ecommerce_app_client/Core/View/cart/cartScreen.dart';
import 'package:ecommerce_app_client/Core/View/checkout/checkoutScreen.dart';
import 'package:ecommerce_app_client/Core/View/favorite/favouriteScreen.dart';
import 'package:ecommerce_app_client/Core/View/homeScreen/homeScreen.dart';
import 'package:ecommerce_app_client/Core/View/onBoarding/onBoardingScreen.dart';
import 'package:ecommerce_app_client/Core/View/order/orderScreen.dart';
import 'package:ecommerce_app_client/Core/View/productDetailScreen/productDetailScreen.dart';
import 'package:ecommerce_app_client/Core/View/profile/profileScreen.dart';
import 'package:ecommerce_app_client/Core/View/setting/settingScreen.dart';
import 'package:ecommerce_app_client/Core/View/store/storeScreen.dart';
import 'package:ecommerce_app_client/Core/View/subCategories/subCategoriesScreen.dart';
import 'package:ecommerce_app_client/Core/View/successScreen.dart/successScreen.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Core/View/auth/changeNamed/changeNamed.dart';
import '../Core/View/auth/forgetPassword/resetPassword.dart';
import '../Core/View/auth/reAuthLoginForm/reAuthLoginForm.dart';

class RouteManager {
  static Route<dynamic>? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case "/splash":
        return MaterialPageRoute(builder: (ctx) {
          return Splashscreen();
        });

      case "/OnboardingScreen":
        return MaterialPageRoute(builder: (ctx) {
          return OnboardingScreen();
        });

      case "/Login":
        return MaterialPageRoute(builder: (ctx) => Login());

      case "/Createaccount":
        return MaterialPageRoute(builder: (ctx) {
          return Register();
        });
 case "/ResetPassword":  
        return MaterialPageRoute(builder: (ctx) {
          return ResetPassword(


          );
        });
      case "/VerifyEmail":
        return MaterialPageRoute(builder: (ctx) {
          return VerifyEmail();
        });

      case "/ForgetPasswordScreen":
        return MaterialPageRoute(builder: (ctx) {
          return ForgetPasswordScreen();
        });

 case "/ReAuthLoginForm":
        return MaterialPageRoute(builder: (ctx) {
          return ReAuthLoginForm();
        });
              case "/Navigationmenu":

                  Rx<int?>? selected = setting.arguments as    Rx<int?>?;


        return MaterialPageRoute(builder: (ctx) {
          return Navigationmenu(

            selected:selected ?? null,
          );
        });

      case "/Homescreen":
        return MaterialPageRoute(builder: (ctx) {
          return Homescreen();
        });

      case "/SubCategoriesScreen":
        CategoryModel category = setting.arguments as CategoryModel;
        return MaterialPageRoute(builder: (ctx) {
          return  SubCategoriesScreen(category: category,);
        });

      case "/CartScreen":
        return MaterialPageRoute(builder: (ctx) {
          return CartScreen();
        });

      case "/ProductDetailScreen":
         ProductModel product = setting.arguments as ProductModel;
        return MaterialPageRoute(builder: (ctx) {
          return ProductDetailScreen(product:product ,);
        });

      case "/FavouriteScreen":
        return MaterialPageRoute(builder: (ctx) {
          return FavouriteScreen();
        });
      case "/SettingsScreen":
        return MaterialPageRoute(builder: (ctx) {
          return SettingsScreen();
        });
      case "/ProfileScreen":
        return MaterialPageRoute(builder: (ctx) {
          return ProfileScreen();
        });
             case "/ChangeName":
        return MaterialPageRoute(builder: (ctx) {
          return ChangeName();
        });

      case "/UserAddressScreen":
        return MaterialPageRoute(builder: (ctx) {
          return UserAddressScreen();
        });

      case "/AddNewAddressScreen":
        return MaterialPageRoute(builder: (ctx) {
          return AddNewAddressScreen();
        });

      case "/StoreScreen":
        return MaterialPageRoute(builder: (ctx) => StoreScreen());

      case "/CheckoutScreen":
        return MaterialPageRoute(builder: (ctx) => CheckoutScreen());

      case "/BrandProducts":
         BrandModel brand = setting.arguments as BrandModel;
        return MaterialPageRoute(builder: (ctx) => BrandProducts(brand:brand ,));

      case "/AllBrandsScreen":
        return MaterialPageRoute(builder: (ctx) => AllBrandsScreen());

      case "/AllProducts":
        final Map<String, dynamic> args = setting.arguments as Map<String, dynamic>;
  
  String title = args['title'];
    Future<List<ProductModel>>?  futureMethod = args['futureMethod'];
  Query<Object?>? query = args['query'];
 

        return MaterialPageRoute(builder: (ctx) => AllProducts(title: title,futureMethod: futureMethod, query: query,));

      case "/OrderScreen":
        return MaterialPageRoute(builder: (ctx) => OrderScreen());

      case '/Successscreen':
       final Map<String, dynamic> args = setting.arguments as Map<String, dynamic>;
  
  String img = args['image'];
  String title = args['title'];
  String subTitle = args['subTitle'];
  VoidCallback onPressed = args['onPressed'];
        return MaterialPageRoute(
            builder: (ctx) => Successscreen(
                  image: img,
                  title: title,
                  subTitle: subTitle,
                  onPressed: onPressed,
                ));
    }
    return null;
  }
}
