


// Exception class for handling various platform-related errors.
class PlatformExcept implements Exception {
  final String code;
  final String? customMessage;
  PlatformExcept(this.code ,  [this.customMessage] );

  String get message {
  
 if (customMessage != null) {
      return customMessage!;
    } 
 
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid.';
      case 'operation-not-allowed':
        return 'The sign-in provider is disabled for your Firebase project.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'network-request-failed':
        return 'Sign-in failed. Please try again.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'internal-error':
        return 'Internal error. Please try again later.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      // Add more cases as needed...
      default:
        return 'An unexpected error occurred.';
    }
  }
}












// class PlatformExcept implements Exception {
//   /// The error code associated with the exception.
//   final String code;

//   /// Optional error message or details.
//   // final String message;

//   /// Constructor that takes an error code and optional message.
//   PlatformExcept(this.code);

//   /// Get the corresponding error message based on the error code.
//    String get message {
//     switch (code) {
//       case 'PERMISSION_DENIED':
//         return 'Permission was denied. Please enable the required permission and try again.';
//       case 'SERVICE_DISABLED':
//         return 'The required service is disabled. Please enable it and try again.';
//       case 'NETWORK_ERROR':
//         return 'A network error occurred. Please check your internet connection and try again.';
//       case 'PLATFORM_NOT_SUPPORTED':
//         return 'This feature is not supported on your platform.';
//       case 'INVALID_ARGUMENT':
//         return 'Invalid argument provided. Please check your input and try again.';
//       case 'UNAVAILABLE':
//         return 'The requested service or feature is currently unavailable.';
//       case 'INTERNAL_ERROR':
//         return 'An internal error occurred. Please try again later.';
//       case 'TIMEOUT':
//         return 'The operation timed out. Please try again later.';
//       case 'USER_CANCELLED':
//         return 'The operation was cancelled by the user.';
//       case 'UNKNOWN_ERROR':
//         return 'An unknown error occurred. Please contact support for assistance.';
//       default:
//         return  'An unexpected platform error occurred.';
//     }
//   }
// }
