import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_client/Core/Model/userModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/Core/server/authController.dart';
import 'package:ecommerce_app_client/global/function/networkManager.dart';
import 'package:ecommerce_app_client/helper/Exceptions/firebaseException.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../global/constants/Images.dart';
import '../../../global/loader/fullScreenLoader.dart';
import '../../../global/loader/loader.dart';
import '../../../helper/Exceptions/firebaseAuthException.dart';
import '../../../helper/Exceptions/formatException.dart';
import '../../../helper/Exceptions/platformException.dart';
import '../../../helper/Exceptions/supabaseException.dart';
import '../../../helper/getstorage_helper.dart';

class UserVM extends GetxController {
  static UserVM get instance => Get.find();

  // Authenticationvm authenticationvm = Authenticationvm.instance;
  Authenticationvm? authenticationvm;

  GetstorageHelper getstorageHelper = GetstorageHelper.instance;
  //= Get.find();
  SupabaseClient client = Supabase.instance.client;
//  UserModel? userModel;
  Rx<UserModel> userModel = UserModel.empty().obs;
  final imageUploading = false.obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = firebase_auth.FirebaseAuth.instance;
  firebase_auth.User? get authUser => _auth.currentUser;
  final loadingProfile = false.obs;

  TextEditingController fullName = TextEditingController();
  //  late AuthController authController ;
  //{AuthController? authController}
  UserVM() {
    //  authController?.getUserData();
    // fetchUserRecord();
    // fetchUser();
    //   initializeNames();
  }
  //  @override
  // void onReady() {

  //   super.onReady();
  // }
  @override
  void onInit() {
     fetchUserRecord();
 //   fetchUser();
    initializeNames();
    super.onInit();
  }

  @override
  void onClose() {
    fullName.dispose();

    super.onClose();
  }

  Future<void> insertUser(
      {required String email,
      required String nameUser,
      required String phone,
      String? profilePicture}) async {
    try {
      await fetchUser();
      if (this.userModel.value.id!.isEmpty) {
        await client.from("users").insert({
          'user_id': client.auth.currentUser!.id,
          'userName': nameUser,
          'email': email,
          'phoneNumber': phone,
          'profilePicture': profilePicture
        });
      }
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

  Future<void> fetchUserData() async {
    try {
      String user_id = getstorageHelper.readFromFile("currentUserId");
      print(user_id);
      List<Map<String, dynamic>> data =
          await client.from("users").select().eq("user_id", user_id);
      //     if (data == null) {
      //         Loaders.errorSnackBar(title: "null", message: data.toString());
      //     }
      // print(data);
      UserModel userModel = UserModel.formJson(data.first);

      this.userModel.value = userModel;
      fullName.text = userModel.user_name!;
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

  Future<void> fetchUser() async {
    try {
      //  Loaders.errorSnackBar(title: "null", message: "${client
      //     .from("users")
      //     .select()
      //     .eq("user_id", client.auth.currentUser!.id)}"
      //     );
      loadingProfile.value = true;
      await fetchUserData();
      loadingProfile.value = false;
    } catch (e) {
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

// Function to remove user data from Firestore.
  Future<void> removeUserRecordSupabase(String userId) async {
    try {
      String user_id = getstorageHelper.readFromFile("currentUserId");
      await client.from('users').delete().eq('user_id', user_id);
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

  Future<void> deleteAccountSupabase() async {
    try {
      String user_id = getstorageHelper.readFromFile("currentUserId");
      await removeUserRecordSupabase(user_id);

      await client.auth.admin.deleteUser(user_id);
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

  Future<void> deleteUserAccountSupabase() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing', ImagesConstant.successfully_done);

      // الحصول على المستخدم الحالي
      final currentUser = client.auth.currentUser;
      if (currentUser == null) {
        throw SupabaseExcept('auth_user_not_found');
      }

      // التحقق من طريقة تسجيل الدخول
      final provider = currentUser.appMetadata['provider'];
      if (provider == 'google') {
        await authenticationvm!.googleSignIn();
        await deleteAccountSupabase();
        FullScreenLoader.stopLoadingDialog();
        Get.offAllNamed("/Login");
      } else if (provider == 'email') {
        FullScreenLoader.stopLoadingDialog();
        Get.offAllNamed("/ReAuthLoginForm"); // توجيه المستخدم لإعادة المصادقة
      }
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

  Future<void> updateUserDetailsSupabase(UserModel updatedUser) async {
    try {
      String user_id = getstorageHelper.readFromFile("currentUserId");
      await client
          .from('users')
          .update(updatedUser.toJson())
          .eq('user_id', user_id);
    } on AuthApiException catch (e) {
      throw SupabaseExcept("خطاء", e.message);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateSingleFieldSupabase(Map<String, dynamic> json) async {
    // Map<String, dynamic> json
    try {
      // await client
      //         .from('users')
      //         .update(json)
      //        .eq('user_id', client.auth.currentUser!.id);
      String user_id = getstorageHelper.readFromFile("currentUserId");
      client.auth.onAuthStateChange.listen((data) async {
        final session = data.session;
        print("ahmed  " + session!.user.id);

        if (session?.user != null) {
          await client.from('users').update(json).eq('user_id', user_id);
        }
      });
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

  Future<void> updateUserNameSupabase() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('We are updating your information...',
          ImagesConstant.successfully_done);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }

// Update user's first & last name in the Firebase Firestore
      // Map<String, dynamic> name = {
      //   'FirstName': firstName.text.trim(),
      //   'LastName': lastName.text.trim()
      // };

      Map<String, dynamic> name = {
        'userName': fullName.text.trim(),
      };

      await updateSingleFieldSupabase(name);

// Update the Rx User value
      // userController.user.value.firstName = firstName.text.trim();
      // userController.user.value.lastName = lastName.text.trim();
      userModel.value.user_name = fullName.text.trim();

// Remove Loader
      FullScreenLoader.stopLoadingDialog();

// Show Success Message
      Loaders.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated.');

// Move to previous screen.
      Get.offNamed("/ProfileScreen");
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

  /// Upload any Image to Supabase Storage
  Future<String> uploadImageSupabase(String path, XFile image) async {
    try {
      // تحميل الملف إلى Supabase Storage
      final file = File(image.path);
      // final fileName = image.name;
      // String safeFileName = image.name.replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');

      String fileExtension = image.name.split('.').last;
      final fileName1 = "${client.auth.currentUser!.id}.$fileExtension";
//      print("🔍 Trying to delete: '$path$fileName1'");
//      // طباعة جميع الملفات في المسار المحدد قبل الحذف
// final listBeforeDelete = await client.storage.from("User").list( path:"User");

// print("📂 الملفات قبل الحذف:");
// for (var file in listBeforeDelete) {
//   print(file.name);
// }

// // تنفيذ عملية الحذف
// final removeResponse = await client.storage.from("User").remove(['$path/$fileName1']);

// if (removeResponse.isNotEmpty) {
//   print("✅ File deleted successfully: $removeResponse");
// } else {
//   print("⚠️ Warning: File might not have been deleted!");
// }

// // طباعة الملفات بعد الحذف
// final listAfterDelete = await client.storage.from("User").list(path:"User");

// print("📂 الملفات بعد الحذف:");
// for (var file in listAfterDelete) {
//   print(file.name);
// }




 await client.storage.from("User").remove(['$path$fileName1']);


// انتظار 1 ثانية للتأكد من حذف الملف نهائيًا
 //await Future.delayed(Duration(seconds: 10));

      await client.storage
          .from('User') // استبدل بـ bucket name الخاص بك
          .upload('$path/$fileName1', file, fileOptions: const FileOptions(upsert: true));

      // // الحصول على رابط الصورة
      // final imageUrl =
      //     client.storage.from('User').getPublicUrl('$path/$fileName1');

// الحصول على رابط الصورة مع تفادي التخزين المؤقت
final timestamp = DateTime.now().millisecondsSinceEpoch;
final imageUrl = "${client.storage.from('User').getPublicUrl('$path/$fileName1')}?t=$timestamp";



      return imageUrl;
    } catch (e) {
        throw 'حدث خطأ ما . حاول مرة اخرى : $e';
    }
  }

  /// Upload User Profile Picture
  Future<void> uploadUserProfilePictureSupabase() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        imageUploading.value = true;

        // تحميل الصورة إلى Supabase Storage
        final imageUrl = await uploadImageSupabase('User/', image);

        // تحديث سجل المستخدم في Supabase
        await client
                .from('users') // استبدل بـ اسم جدول المستخدمين الخاص بك
                .update({'profilePicture': imageUrl}).eq('user_id',
                    client.auth.currentUser!.id) // تحديث المستخدم الحالي
            ;

        // if (response.error != null) {
        //   throw response.error!.message;
        // }

        // تحديث القيمة المحلية
        userModel.value.profilePicture = imageUrl;
        userModel.refresh();

        Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Profile Image has been updated!',
        );
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'خطاء',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }
//--------------------------------------------------------------------------------

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("users").doc(user.id).set(user.toJson());
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

  Future<void> saveUserRecordFirebase(
      firebase_auth.UserCredential? userCedential) async {
    try {
      await fetchUser();
      if (this.userModel.value.id!.isEmpty) {
        if (userCedential != null) {
          final userName =
              UserModel.generateUsername(userCedential.user!.displayName ?? '');

          final user = UserModel(
              id: userCedential.user!.uid,
              user_name: userName,
              email: userCedential.user!.email ?? '',
              phoneNumber: userCedential.user!.phoneNumber ?? '',
              profilePicture: userCedential.user!.photoURL ?? '');

          await saveUserRecord(user);
        }
      }
    } catch (e) {
      if (e is FirebaseAuthExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FirebaseExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is PlatformExcept) {
        Loaders.errorSnackBar(title: e.code, message: e.message);
      } else if (e is FormatExcept) {
        Loaders.errorSnackBar(title: "Oh Snap", message: e.message);
      } else {
        Loaders.warningSnackBar(
          title: 'Data not Save !!',
          message: e.toString(),
        );
      }
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot =
          await _db.collection('users').doc(authUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw FirebaseExcept(e.code, e.message);
    } on FormatException catch (_) {
      throw const FormatExcept();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code, e.message);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> fetchUserRecord() async {
    try {
      loadingProfile.value = true;
      final user = await fetchUserDetails();

      userModel(user);
    } catch (e) {
      userModel(UserModel.empty());
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
    } finally {
      loadingProfile.value = false;
    }
  }

// Delete User Account
  Future<void> deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing', ImagesConstant.successfully_done);

      // First re-authenticate user
      //  final auth = AuthenticationRepository.instance;
      final provider = authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await authenticationvm!.signInWithGoogle();
          await deleteAccount();
          FullScreenLoader.stopLoadingDialog();
          Get.offAllNamed("/Login");
        } else if (provider == 'password') {
          FullScreenLoader.stopLoadingDialog();

          Get.offAllNamed("/ReAuthLoginForm");
        }
      }
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

// Function to update user data in Firestore.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection('users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
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

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    // Map<String, dynamic> json
    try {
      await _db.collection('users').doc(authUser?.uid).update(json);
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

// Function to remove user data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
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

  Future<void> deleteAccount() async {
    try {
      await removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
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

  /// Fetch user record
  Future<void> initializeNames() async {
    fullName.text = userModel.value.user_name!;

    // lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('We are updating your information...',
          ImagesConstant.successfully_done);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoadingDialog();
        return;
      }

// Update user's first & last name in the Firebase Firestore
      // Map<String, dynamic> name = {
      //   'FirstName': firstName.text.trim(),
      //   'LastName': lastName.text.trim()
      // };

      Map<String, dynamic> name = {
        'userName': fullName.text.trim(),
      };

      await updateSingleField(name);

// Update the Rx User value
      // userController.user.value.firstName = firstName.text.trim();
      // userController.user.value.lastName = lastName.text.trim();
      userModel.value.user_name = fullName.text.trim();

// Remove Loader
      FullScreenLoader.stopLoadingDialog();

// Show Success Message
      Loaders.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated.');

// Move to previous screen.
      Get.offNamed("/ProfileScreen");
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

  /// Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw FirebaseExcept(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExcept();
    } on PlatformException catch (e) {
      throw PlatformExcept(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        // Upload Image
        final imageUrl = await uploadImage('Users/Images/Profile/', image);

        // Update User Image Record
        Map<String, dynamic> json = {'profilePicture': imageUrl};
        await updateSingleField(json);
        userModel.value.profilePicture = imageUrl;
        userModel.refresh();

        Loaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your Profile Image has been updated!');
      }
    } catch (e) {
      Loaders.errorSnackBar(
          title: 'Oh Snap', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
