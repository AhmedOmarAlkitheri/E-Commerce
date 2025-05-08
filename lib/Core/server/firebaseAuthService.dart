import 'package:ecommerce_app_client/Core/Model/userModel.dart';
import 'package:ecommerce_app_client/Core/ViewModel/auth/authenticationVM.dart';
import 'package:ecommerce_app_client/Core/ViewModel/user/user.dart';
import 'package:ecommerce_app_client/Core/server/servies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Authenticationvm _authenticationvm = Get.put(Authenticationvm());
  final UserVM _userVM = Get.put(UserVM());

  @override
  Future<void> register() async {
    await _authenticationvm.signup();
  }

  @override
  Future<void> signIn() async {
    await _authenticationvm.emailAndPasswordSignIn();
  }

  @override
  Future<void> signInWithGoogle() async {
    await _authenticationvm.googleSignIn();
    //googleWithSignInFirebase();
  }

  @override
  Future<void> sendEmailVerification() async {
    await _authenticationvm.sendPasswordResendEmailFirebase();
  }

  @override
  Future<void> validateCredentials() async {
    await _authenticationvm.reAuthenticateEmailAndPasswordUser();
  }

  @override
  Future<void> signOut() async {
    await _authenticationvm.logOutLogin();
  }

  @override
  Future<void> deleteUser() async {
    await _userVM.deleteUserAccount();
  }

  @override
  Future<void> updateUser(UserModel updatedUser) async {
    await _userVM.updateUserDetails(updatedUser);
  }

  @override
  Future<void> getUserData() async {
    await _userVM.fetchUserRecord();
  }

  @override
  Future<void> updateUserNameProfile() async {
    await _userVM.updateUserName();
  }
}
