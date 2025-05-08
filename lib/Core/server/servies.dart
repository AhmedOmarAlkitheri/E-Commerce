import '../Model/userModel.dart';

abstract class AuthService {
  // ✅ تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور
  Future<void> signIn();

  // ✅ تسجيل مستخدم جديد باستخدام البريد الإلكتروني وكلمة المرور
  Future<void> register();

  // ✅ تسجيل الدخول باستخدام حساب Google
  Future<void> signInWithGoogle();

  // ✅ تسجيل الخروج
  Future<void> signOut();

  // // ✅ الحصول على معرف المستخدم الحالي
  // Future<String?> getCurrentUserId();

  // // ✅ إرسال رابط إعادة تعيين كلمة المرور
  // Future<void> forgotPassword(String email);

  // ✅ إرسال رابط تأكيد البريد الإلكتروني
  Future<void> sendEmailVerification();

  
  // ✅ التحقق من صحة البريد الإلكتروني وكلمة المرور
  Future<void> validateCredentials();

  // // ✅ إضافة مستخدم جديد (مثل إضافة بيانات إضافية)
  // Future<void> addUser(Map<String, dynamic> userData);

  // ✅ حذف مستخدم
  Future<void> deleteUser();

  // ✅ تحديث بيانات المستخدم
  Future<void> updateUser(UserModel updatedUser);

  // ✅ جلب بيانات المستخدم
  Future<void> getUserData();

  Future<void> updateUserNameProfile();
  

}