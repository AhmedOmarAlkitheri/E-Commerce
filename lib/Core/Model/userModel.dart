import 'package:cloud_firestore/cloud_firestore.dart';

import '../../global/function/formatter.dart';

class UserModel {
  String? id, email, user_name , phoneNumber , profilePicture ;

  UserModel({ this.id,  this.user_name,  this.email , this.phoneNumber , this.profilePicture});
  
   static UserModel empty() => UserModel(
        id: '',
     
        user_name: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
      );

  UserModel.formJson(Map<String, dynamic> fromjson) {
    id = fromjson["user_id"] ?? '';
    user_name = fromjson["userName"]?? '';
    email = fromjson["email"]?? '';
    phoneNumber=  fromjson["phoneNumber"]?? '';
   profilePicture=  fromjson["profilePicture"]?? '';
  }
  

   String get formattedPhoneNo => Formatter.formatPhoneNumber(phoneNumber ??  "");

  /// Static function to split full name into first and last name.
  static List<String> nameParts(String fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model.
 
  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      // 'FirstName': firstName,
      // 'LastName': lastName,
      'userName': user_name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        // firstName: data['FirstName'] ?? '',
        // lastName: data['LastName'] ?? '',
        user_name: data['userName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    }
    throw Exception("Document data is null");
  }
}
