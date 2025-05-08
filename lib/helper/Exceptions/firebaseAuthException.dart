class FirebaseAuthExcept implements Exception {
  /// The error code associated with the exception.
    final String code;

  /// The custom message associated with the exception.
  final String? customMessage;

  /// Constructor that takes an error code and an optional custom message.
  FirebaseAuthExcept(this.code, [this.customMessage]);

  /// Get the corresponding error message based on the error code or use the custom message.
  String get message {
    // If a custom message is provided, use it.
    if (customMessage != null) {
      return customMessage!;
    }
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'email-already-exists':
        return 'The email address already exists. Please use a different email.';
      case 'provider-already-Linked':
        return 'The account is already linked with another provider.';
      default:
        return 'An unknown error occurred.';
    }
  }
}
