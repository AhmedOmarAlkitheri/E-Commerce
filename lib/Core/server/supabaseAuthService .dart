import 'package:ecommerce_app_client/Core/ViewModel/user/user.dart';
import 'package:ecommerce_app_client/Core/server/servies.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/userModel.dart';
import '../ViewModel/auth/authenticationVM.dart';

class SupabaseAuthService implements AuthService {

  
  final SupabaseClient _supabase = Supabase.instance.client;
  final Authenticationvm _authenticationvm = Get.put(Authenticationvm());
  final UserVM _userVM = Get.put(UserVM());

  // @override
  // Future<void> addUser(Map<String, dynamic> userData) async{
  //  await _userVM.insertUser();
  // }

  @override
  Future<void> deleteUser() async {
      await _userVM.deleteUserAccountSupabase();
  }

  @override
  Future<void> getUserData() async {
    await _userVM.fetchUser();
  }

  @override
  Future<void> register() async {
    await _authenticationvm.register();
  }

  @override
  Future<void> sendEmailVerification() async {
    await _authenticationvm.resetPassword();
  }

  @override
  Future<void> signIn() async {
    await _authenticationvm.loginEmail();
  }

  @override
  Future<void> signInWithGoogle() async {
    await _authenticationvm.googleSignIn();
  }

  @override
  Future<void> signOut() async {
    await _authenticationvm.signout();
  }

  @override
  Future<void> updateUser(UserModel updatedUser
     ) async {
        await _userVM.updateUserDetailsSupabase(updatedUser);
     }

  @override
  Future<void> validateCredentials() async {
     await _authenticationvm.reAuthenticateEmailAndPasswordUserSupabase();
  }
  
  @override
  Future<void> updateUserNameProfile() async {
     await _userVM.updateUserNameSupabase();
   
  }
  
  
}
