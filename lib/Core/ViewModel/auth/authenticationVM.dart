import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_client/Core/Model/userModel.dart';
import 'package:ecommerce_app_client/Core/View/auth/reAuthLoginForm/reAuthLoginForm.dart';
import 'package:ecommerce_app_client/Core/ViewModel/user/user.dart';
import 'package:ecommerce_app_client/global/constants/Images.dart';
import 'package:ecommerce_app_client/global/constants/Sizes.dart';
import 'package:ecommerce_app_client/global/constants/apiConstant.dart';
import 'package:ecommerce_app_client/helper/Exceptions/supabaseException.dart';
import 'package:ecommerce_app_client/helper/getstorage_helper.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../global/function/networkManager.dart';
import '../../../global/loader/fullScreenLoader.dart';
import '../../../global/loader/loader.dart';
import '../../../helper/Exceptions/firebaseAuthException.dart';
import '../../../helper/Exceptions/firebaseException.dart';
import '../../../helper/Exceptions/formatException.dart';
import '../../../helper/Exceptions/platformException.dart';
import '../../Model/userModelFirebase.dart';
import '../../View/auth/login/login.dart';

class Authenticationvm extends GetxController {
  //static Authenticationvm get instance => Get.find();
  //  VARIBLES -------------------------------------------VARIBLES ----------------

  // UserVM userVM = UserVM.instance ;
  UserVM userVM = UserVM.instance;
  SupabaseClient client = Supabase.instance.client;
  Rx<bool> obscureText = true.obs;
  Rx<bool> obscureLoginText = true.obs;
  Rx<bool> checkRemember = false.obs;

  Rx<bool> hidePassword = false.obs;
  final _auth = firebase_auth.FirebaseAuth.instance;

  firebase_auth.User? get authUser => _auth.currentUser;
  // Rx<UserModel> userModel = UserModel.empty().obs;
  GoogleSignInAccount? googleUser;
  String message = "";

  GetstorageHelper getstorageHelper = GetstorageHelper.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  TextEditingController nameUserController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sendEmailController = TextEditingController();

  TextEditingController verifyEmail = TextEditingController();
  TextEditingController verifyPassword = TextEditingController();




  @override
  void onInit() {
  getstorageHelper.writeToFile(key: "StateInstall", value: false);
        super.onInit();
  }
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameUserController.dispose();
    confirmPasswordController.dispose();
    passwordLoginController.dispose();
    phoneController.dispose();
    sendEmailController.dispose();
    emailLoginController.dispose();
    passwordLoginController.dispose();
    verifyPassword.dispose();
    verifyEmail.dispose();
    super.onClose();
  }

  // SUPABASE ==================================== SUPABASE ====================================
/*
 {required String email,
      required String password,
      required String confirmPassword,
      required String nameUser,
      required String phone}
      */
  Future<void> register() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'We are processing your information...',
          ImagesConstant.successfully_done);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      await client.auth.signUp(
          password: passwordController.text, email: emailController.text);
      userVM.insertUser(
          email: emailController.text,
          nameUser: nameUserController.text,
          phone: phoneController.text);

      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show Success Message
      Loaders.successSnackBar(
        title: 'Congratulations',
        message:
            'Your account has been created! Verify your email to continue.',
      );

      // Move to Verify Email Screen
      Get.toNamed("/VerifyEmail");
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show some generic error to the user
      if (e is SupabaseExcept) {
        Loaders.errorSnackBar(title: 'خطاء', message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    }
  }

  Future<void> signInWithPassword() async {
    try {
      // await client.auth.signInWithPassword(
      //     password: emailLoginController.text,
      //     email: passwordLoginController.text);
      await client.auth.signInWithPassword(
          password: emailLoginController.text.trim(),
          email: passwordLoginController.text.trim());
    } on SupabaseExcept catch (e) {
      throw SupabaseExcept('خطاء', e.message);
    } on FormatException catch (_) {
      throw FormatExcept();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw 'حدث خطأ ما . حاول مرة اخرى';
    }
  }

// {required String email, required String password}
  Future<void> loginEmail() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Loading sigin in...', ImagesConstant.successfully_done);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        FullScreenLoader.stopLoadingDialog();
        return;
      }
      //  AuthResponse response =

      //  await signInWithPassword();
      await client.auth.signInWithPassword(
          password: emailLoginController.text.trim(),
          email: passwordLoginController.text.trim());
      await client.auth.refreshSession();

      getstorageHelper.writeToFile(
          key: "currentUserId", value: client.auth.currentUser!.id);
   
      if (checkRemember.value) {
        getstorageHelper.writeToFile(
            key: 'REMEMBER_ME_EMAIL', value: emailLoginController.text.trim());

        getstorageHelper.writeToFile(
            key: 'REMEMBER_ME_PASSWORD',
            value: passwordLoginController.text.trim());
      } else {
        getstorageHelper.writeToFile(key: 'REMEMBER_ME_EMAIL', value: "");

        getstorageHelper.writeToFile(key: 'REMEMBER_ME_PASSWORD', value: "");
      }
      FullScreenLoader.stopLoadingDialog();

      // Show Success Message
      Loaders.successSnackBar(
        title: 'Login Seccuss',
        message: 'Send Email Link , To Reset Your Password.'.tr,
      );
      Get.toNamed("/Navigationmenu");

      //  return response;
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show some generic error to the user
      if (e is SupabaseExcept) {
        Loaders.errorSnackBar(title: 'خطاء', message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    }
  }

// Future<void> googleSignIn() async {
//   try {
//     // فتح شاشة التحميل
//     FullScreenLoader.openLoadingDialog(
//         'Loading sign in...', ImagesConstant.successfully_done);

//     // التحقق من الاتصال بالإنترنت
//     final isConnected = await NetworkManager.instance.isConnected();
//     if (!isConnected) {
//       FullScreenLoader.stopLoadingDialog();
//       Loaders.errorSnackBar(title: "خطأ", message: "تحقق من اتصال الإنترنت.");
//       return;
//     }

//     // تسجيل الدخول باستخدام Google Sign-In
//     final GoogleSignIn googleSignIn = GoogleSignIn(
//       serverClientId: ApiConstant.webClientId,
//     );

//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) {
//       FullScreenLoader.stopLoadingDialog();
//       Loaders.errorSnackBar(title: "إلغاء", message: "تم إلغاء تسجيل الدخول.");
//       return;
//     }

//     final googleAuth = await googleUser.authentication;
//     final idToken = googleAuth.idToken;
//     final accessToken = googleAuth.accessToken;

//     if (idToken == null || accessToken == null) {
//       FullScreenLoader.stopLoadingDialog();
//       Loaders.errorSnackBar(title: "خطأ", message: "تعذر الحصول على بيانات المصادقة.");
//       return;
//     }

//     // تسجيل الدخول في Supabase باستخدام Google OAuth
//     final response = await client.auth.signInWithIdToken(
//       provider: OAuthProvider.google,
//       idToken: idToken,
//       accessToken: accessToken,
//     );

//     if (response.user == null) {
//       FullScreenLoader.stopLoadingDialog();
//       Loaders.errorSnackBar(title: "خطأ", message: "فشل تسجيل الدخول في Supabase.");
//       return;
//     }

//     // تسجيل الدخول في Firebase باستخدام Google OAuth
//     final firebaseCredential = firebase_auth.GoogleAuthProvider.credential(
//       idToken: idToken,
//       accessToken: accessToken,
//     );

//     final userCredential = await firebase_auth.FirebaseAuth.instance
//         .signInWithCredential(firebaseCredential);

//     if (userCredential.user == null) {
//       FullScreenLoader.stopLoadingDialog();
//       Loaders.errorSnackBar(title: "خطأ", message: "فشل تسجيل الدخول في Firebase.");
//       return;
//     }

//     // حفظ بيانات المستخدم في قاعدة البيانات
//     await userVM.insertUser(
//       email: response.user!.email ?? "",
//       nameUser: response.user!.userMetadata?['full_name'] ?? "Unknown User",
//       phone: response.user!.phone ?? "",
//       profilePicture: response.user!.userMetadata?['avatar_url'] ?? "",
//     );

//     // حفظ بيانات المستخدم في Firebase أيضًا
//     userVM.saveUserRecordFirebase(userCredential);

//     // تخزين ID المستخدم
//     getstorageHelper.writeToFile(
//       key: "currentUserId",
//       value: response.user!.id,
//     );

//     print("User ID: ${response.user!.id}");

//     FullScreenLoader.stopLoadingDialog();

//     // عرض رسالة نجاح
//     Loaders.successSnackBar(
//       title: 'تم تسجيل الدخول',
//       message: 'تم تسجيل الدخول بنجاح!',
//     );

//     // الانتقال إلى الشاشة الرئيسية
//     Get.offAllNamed("/Navigationmenu");

//   } catch (e) {
//     FullScreenLoader.stopLoadingDialog();

//     // التعامل مع الأخطاء بطريقة أوضح
//     String errorMessage = "حدث خطأ غير متوقع.";
//     if (e is SupabaseExcept) {
//       errorMessage = e.message;
//     } else if (e is PlatformExcept) {
//       errorMessage = "${e.code}: ${e.message}";
//     } else if (e is FormatExcept) {
//       errorMessage = e.message;
//     } else {
//       errorMessage = e.toString();
//     }

//     Loaders.errorSnackBar(title: "خطأ", message: errorMessage);
//   }
// }

  Future<void> googleSignIn() async {
    try {
      // const androidClientId =  '781951736122-fhs4jp55h0egadlgp9m36d3a5i73fr1o.apps.googleusercontent.com';
      FullScreenLoader.openLoadingDialog(
          'Loading sigin in...', ImagesConstant.successfully_done);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        FullScreenLoader.stopLoadingDialog();
        return;
      }
      final GoogleSignIn googleSignIn = GoogleSignIn(
        // clientId: androidClientId  ,
        serverClientId: ApiConstant.webClientId,
      );
      googleUser = await googleSignIn.signIn();
      // if (googleUser == null) {
      //   return AuthResponse();
      // }
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      // if (accessToken == null || idToken == null) {
      //   message = 'Access Token or idToken Not found.';
      //   return AuthResponse();
      // }

      //  AuthResponse response =
      // AuthResponse
      //   userCredential =

      await client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken!,
        accessToken: accessToken,
      );
      // final firebaseCredential =
      //       firebase_auth.GoogleAuthProvider.credential(idToken: idToken ,  accessToken: accessToken,);

      //   final userCredential = await firebase_auth.FirebaseAuth.instance
      //       .signInWithCredential(firebaseCredential);
      getstorageHelper.writeToFile(
          key: "currentUserId", value: client.auth.currentUser!.id);
      await userVM.insertUser(
        email: client.auth.currentUser!.email ?? "",
        nameUser: client.auth.currentUser!.userMetadata?['full_name'] ??
            "Unknown User",
        phone: client.auth.currentUser!.phone ?? "",
        profilePicture:
            client.auth.currentUser!.userMetadata?['avatar_url'] ?? "",
      );
 

  
      FullScreenLoader.stopLoadingDialog();

      // Show Success Message
      Loaders.successSnackBar(
        title: 'Login Seccuss',
        message: 'Send Email Link , To Reset Your Password.'.tr,
      );
      Get.offAllNamed("/Navigationmenu");
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show some generic error to the user
      if (e is SupabaseExcept) {
        Loaders.errorSnackBar(title: 'خطاء', message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    }
    // message = 'success';
    // return response;
  }

  Future<void> signout() async {
    try {
      // GoogleSignIn googleSignIn = GoogleSignIn(
      //   serverClientId: ApiConstant.webClientId,
      // );
      await GoogleSignIn().signOut();
      await client.auth.signOut();
      getstorageHelper.writeToFile(key: "currentUserId" , value: null);
      Get.offAllNamed("/splash");
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
    }
  }

  Future<void> resetPassword() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'processing your request...', ImagesConstant.successfully_done);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      await client.auth.resetPasswordForEmail(sendEmailController.text);

      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show Success Message
      Loaders.successSnackBar(
        title: 'send Email',
        message: 'Send Email Link , To Reset Your Password.'.tr,
      );

      // Move to Verify Email Screen
      Get.toNamed(
        "/ResetPassword",
      );

      //  parameters: {'sendEmail': sendEmailController.text.trim()});
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show some generic error to the user
      if (e is SupabaseExcept) {
        Loaders.errorSnackBar(title: 'خطاء', message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    }
  }

  Future<void> reAuthenticateWithEmailAndPasswordSupabase(
      String email, String password) async {
    try {
      // تسجيل الدخول مرة أخرى
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw SupabaseExcept('auth_user_not_found');
      }
    } on AuthException catch (e) {
      throw SupabaseExcept("خطاء", e.message);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      throw 'حدث خطأ ما . حاول مرة اخرى';
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUserSupabase() async {
    try {
      // عرض شاشة التحميل
      FullScreenLoader.openLoadingDialog(
          'Processing', ImagesConstant.successfully_done);

      // فحص الاتصال بالإنترنت
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      // تنفيذ إعادة المصادقة
      await reAuthenticateWithEmailAndPasswordSupabase(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );
      //  await client.from('users').delete().eq('user_id', "82ab457b-6f1f-40d9-b493-dffeadf03fb2");

      //  await client.auth.admin.deleteUser("82ab457b-6f1f-40d9-b493-dffeadf03fb2");
      // حذف الحساب بعد التأكد من إعادة المصادقة
      await userVM.deleteAccountSupabase();

      // إيقاف شاشة التحميل والانتقال إلى صفحة تسجيل الدخول
      FullScreenLoader.stopLoadingDialog();
      Get.offAllNamed("/Login");
    } catch (e) {
      FullScreenLoader.stopLoadingDialog();
      if (e is SupabaseExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    }
  }

  // firebase ==================================== Firebase ====================================

  Future<void> signup() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          'We are processing your information...',
          ImagesConstant.successfully_done);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      // // Form Validation
      // if (!signupFormKey.currentState!.validate()) {
      //   // Remove Loader
      //   TFullScreenLoader.stopLoading();
      //   return;
      // }

      // // Privacy Policy Check
      // if (!privacyPolicy.value) {
      //   TLoaders.warningSnackBar(
      //     title: 'Accept Privacy Policy',
      //     message:
      //         'In order to create an account, you must read and accept the Privacy Policy & Terms of Use.',
      //   );
      //   return;
      // }

      // Register user in Firebase Authentication & Save user data in Firebase
      final userCredential = await registerWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Save authenticated user data in Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        // firstName: firstName.text.trim(),
        // lastName: lastName.text.trim(),
        user_name: nameUserController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        profilePicture: '',
      );

      //final userRepository = Get.put(UserRepository());

      await userVM.saveUserRecord(newUser);

      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show Success Message
      Loaders.successSnackBar(
        title: 'Congratulations',
        message:
            'Your account has been created! Verify your email to continue.',
      );

      // Move to Verify Email Screen
      Get.toNamed("/VerifyEmail");
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show some generic error to the user
      if (e is FirebaseAuthExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FirebaseExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    }
  }

  Future<firebase_auth.UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthExcept(e.code, e.message);
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

  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          'Logging you in...', ImagesConstant.successfully_done);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      //   // Form Validation
      //   if (!loginFormKey.currentState!.validate()) {
      //  FullScreenLoader.stopLoadingDialog();
      //     return;
      //   }

      // Save Data if Remember Me is selected


      if (checkRemember.value) {
        getstorageHelper.writeToFile(
            key: 'REMEMBER_ME_EMAIL', value: emailLoginController.text.trim());

        getstorageHelper.writeToFile(
            key: 'REMEMBER_ME_PASSWORD',
            value: passwordLoginController.text.trim());
      } else {
        getstorageHelper.writeToFile(key: 'REMEMBER_ME_EMAIL', value: "");

        getstorageHelper.writeToFile(key: 'REMEMBER_ME_PASSWORD', value: "");
      }

// Login using Email & Password Authentication
      // final userCredentials =
      await loginWithEmailAndPassword(emailLoginController.text.trim(),
          passwordLoginController.text.trim());
  getstorageHelper.writeToFile(
          key: "currentUserId", value: _auth.currentUser!.uid);
// Remove Loader
      FullScreenLoader.stopLoadingDialog();

      Get.toNamed("/Navigationmenu");
      //  AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoadingDialog();

      if (e is FirebaseAuthExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FirebaseExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    }
  }

  Future<firebase_auth.UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthExcept(e.code, e.message);
    } on FirebaseException catch (e) {
      throw FirebaseExcept(e.code, e.message);
    } on FormatException catch (e) {
      throw FormatExcept("Format Exception: ${e.message}");
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw 'حدث خطأ ما. حاول مرة اخرى';
    }
  }

  Future<void> googleWithSignInFirebase() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          'Loading sigin in...', ImagesConstant.successfully_done);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      // Register user in Firebase Authentication & Save user data in Firebase
      //await googleSignInFirebase();
      await signInWithGoogle();
  getstorageHelper.writeToFile(
          key: "currentUserId", value: _auth.currentUser!.uid);
   
     
      // Remove Loader
//      final GoogleSignIn googleSignIn = GoogleSignIn(
//         // clientId: "781951736122-1rufrhkmlkapjmasbonis8579onnh9l3.apps.googleusercontent.com"  ,
//       // serverClientId: "781951736122-1rufrhkmlkapjmasbonis8579onnh9l3.apps.googleusercontent.com"
//       );

//  googleUser = await googleSignIn.signIn()  ;

//       // Obtain the auth details from the request
//        final googleAuth =
//           await googleUser?.authentication;
// //  final googleAuth = await googleUser!.authentication;
// //       final accessToken = googleAuth.accessToken;
// //       final idToken = googleAuth.idToken;

// // if( googleAuth?.idToken == null ){
// // Loaders.errorSnackBar(title: "idToken", message: 'لا توجد قيمة');

// // }
//       // Obtain the auth details from the request
//       final authCredential = firebase_auth.GoogleAuthProvider.credential(
//         accessToken:googleAuth!. accessToken,
//         idToken: googleAuth.idToken,
//       );

//       //final UserCredential userCredential = await auth.signInWithCredential(authCredential);
//       final firebase_auth.UserCredential userCredential =
//           await _auth.signInWithCredential(authCredential);
//     userVM.saveUserRecordFirebase(userCredential);
      FullScreenLoader.stopLoadingDialog();

      // Show Success Message
      Loaders.successSnackBar(
        title: 'Login Seccuss',
        message: 'Send Email Link , To Reset Your Password.'.tr,
      );
      Get.offAllNamed("/Navigationmenu");
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show some generic error to the user
      if (e is FirebaseAuthExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FirebaseExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    }
  }

//Google - Federated Identity is social sign-in
  Future<void> signInWithGoogle() async {
    try {
      // // Trigger the authentication flow
      // final GoogleSignInAccount? googleUser = await GoogleSignIn(
      //    // serverClientId: "501362544704-d5grn7jvivqjrkm6l7c09b7rddaklimb.apps.googleusercontent.com"
      // ).signIn();

      // // Obtain the auth details from the request
      // final GoogleSignInAuthentication? googleAuth =
      //     await googleUser?.authentication;

      // // Obtain the auth details from the request
      // final authCredential = firebase_auth.GoogleAuthProvider.credential(
      //   accessToken: googleAuth?.accessToken,
      //   idToken: googleAuth?.idToken,
      // );

      // //final UserCredential userCredential = await auth.signInWithCredential(authCredential);
      // final firebase_auth.UserCredential userCredential =
      //     await _auth.signInWithCredential(authCredential);
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
              // clientId:
              //     "781951736122-fhs4jp55h0egadlgp9m36d3a5i73fr1o.apps.googleusercontent.com",
              // serverClientId:
              //     "501362544704-t028eq02fodo5935rn9p207elv98132j.apps.googleusercontent.com"

              )
          .signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebase_auth.FirebaseAuth.instance.signInWithProvider(
        firebase_auth.GoogleAuthProvider(),
      );

      final userCredential = await firebase_auth.FirebaseAuth.instance
          .signInWithCredential(credential);

      userVM.saveUserRecordFirebase(userCredential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthExcept(e.code, e.message);
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

  Future<void> logOutLogin() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
   getstorageHelper.writeToFile(key: "currentUserId" , value: null);
      Get.offAllNamed("/splash");
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthExcept(e.code, e.message);
    } on FirebaseException catch (e) {
      throw FirebaseExcept(e.code, e.message);

// } on FormatException catch (e){
// throw

// FormatExcept(e.code).message;
// // FormatExcept();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw 'حدث خطأ ما . حاول مرة اخرى';
    }
  }

  Future<void> sendPasswordResendEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthExcept(e.code, e.message);
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

  Future<void> sendPasswordResendEmailFirebase() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          'processing your request...', ImagesConstant.successfully_done);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        FullScreenLoader.stopLoadingDialog();
        return;
      }
      // Register user in Firebase Authentication & Save user data in Firebase
      await sendPasswordResendEmail(
        emailController.text.trim(),
      );

      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show Success Message
      Loaders.successSnackBar(
        title: 'send Email',
        message: 'Send Email Link , To Reset Your Password.'.tr,
      );

      // Move to Verify Email Screen
      Get.toNamed(
        "/ResetPassword",
      );

      //  parameters: {'sendEmail': sendEmailController.text.trim()});
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoadingDialog();

      // Show some generic error to the user
      if (e is FirebaseAuthExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FirebaseExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    }
  }

  // resendPasswordResetEmailFirebase(String email) async {
  //   try {
  //     // Start Loading
  //     FullScreenLoader.openLoadingDialog(
  //         'processing your request...', ImagesConstant.successfully_done);

  //     // Check Internet Connectivity
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       // Remove Loader
  //       FullScreenLoader.stopLoadingDialog();
  //       return;
  //     }
  //     // Register user in Firebase Authentication & Save user data in Firebase
  //     await sendPasswordResendEmail(email);

  //     // Remove Loader
  //     FullScreenLoader.stopLoadingDialog();

  //     // Show Success Message
  //     Loaders.successSnackBar(
  //       title: 'send Email',
  //       message: 'Send Email Link , To Reset Your Password.'.tr,
  //     );
  //   } catch (e) {
  //     // Remove Loader
  //     FullScreenLoader.stopLoadingDialog();

  //     if (e is FirebaseAuthExcept) {
  //       Loaders.errorSnackBar(title: e.code, message: e.message);
  //     } else if (e is FirebaseExcept) {
  //       Loaders.errorSnackBar(title: e.code, message: e.message);
  //     } else if (e is PlatformExcept) {
  //       Loaders.errorSnackBar(title: e.code, message: e.message);
  //     } else if (e is FormatExcept) {
  //       Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
  //     } else {
  //       Loaders.errorSnackBar(title: "oh snap", message: e.toString());
  //     }
  //   }
  // }

//RE-AUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      // Create a credential
      final firebase_auth.AuthCredential credential =
          firebase_auth.EmailAuthProvider.credential(
              email: email, password: password);

      // Re-authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseException catch (e) {
      throw FirebaseExcept(e.code, e.message);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing', ImagesConstant.successfully_done);

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }

      // if (!reAuthFormKey.currentState!.validate()) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      await reAuthenticateWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
        //reAuthFormKey
      );
      await userVM.deleteUserAccount();
      FullScreenLoader.stopLoadingDialog();
      Get.offAllNamed("/Login");
    } catch (e) {
      FullScreenLoader.stopLoadingDialog();
      if (e is FirebaseAuthExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FirebaseExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.errorSnackBar(title: "oh snap", message: e.toString());
      }
    }
  }
}

/*
  // Future<void> sendEmailVerification() async {
  //   try {
  //     await _auth.currentUser!.sendEmailVerification();
  //   } on firebase_auth.FirebaseAuthException catch (e) {
  //     throw FirebaseAuthExcept(e.code, e.message);
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


// @override
// void onInit() {
//   print("===================================================");
//   print(getstorageHelper.readFromFile('REMEMBER_ME_EMAIL'));
//   emailLoginController.text =
//       getstorageHelper.readFromFile('REMEMBER_ME_EMAIL');

//   passwordLoginController.text = getstorageHelper.readFromFile(
//     'REMEMBER_ME_PASSWORD',
//   );
//   print("===================================================");
//   super.onInit();
// }

// @override
// void onReady() {
//   print("===================================================");
//   print(getstorageHelper.readFromFile('REMEMBER_ME_EMAIL'));
//   emailLoginController.text =
//       getstorageHelper.readFromFile('REMEMBER_ME_EMAIL');

//   passwordLoginController.text = getstorageHelper.readFromFile(
//     'REMEMBER_ME_PASSWORD',
//   );
//   print("===================================================");
//   super.onReady();
// }
*/
