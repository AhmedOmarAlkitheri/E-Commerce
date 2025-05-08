
import 'package:ecommerce_app_client/Core/Model/userModel.dart';
import 'package:ecommerce_app_client/Core/server/firebaseAuthService.dart';
import 'package:ecommerce_app_client/Core/server/servies.dart';
import 'package:ecommerce_app_client/Core/server/supabaseAuthService%20.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late AuthService authService;

  AuthController({required bool useFirebase}) {
    authService = useFirebase ? FirebaseAuthService() : SupabaseAuthService();
  }

  Future<void> signIn() async {
    await authService.signIn();
  }

  Future<void> register() async {
    await authService.register();
  }

  Future<void> signInWithGoogle() async {
    await authService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await authService.signOut();
  }

  Future<void> sendEmailVerification() async {
    await authService.sendEmailVerification();
  }

  Future<void> validateCredentials() async {
    await authService.validateCredentials();
  }

  Future<void> deleteUser() async {
    await authService.deleteUser();
  }

  Future<void> updateUser(UserModel updatedUser) async {
    await authService.updateUser(updatedUser);
  }

  Future<void> getUserData() async {
    await authService.getUserData();
  }

  Future<void> updateUserNameProfile() async {
    await authService.updateUserNameProfile();
  }
}