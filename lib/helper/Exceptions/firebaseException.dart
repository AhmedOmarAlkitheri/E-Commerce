class FirebaseExcept implements Exception {

  final String code;
final String? customMessage;

  FirebaseExcept(this.code , [this.customMessage]);


String get message {
    if (customMessage != null) {
      return customMessage!;
    } 
  switch (code) {
    case 'email-already-in-use':
      return 'The email address is already registered. Please use a different email.';
    case 'invalid-email':
      return 'The email address is invalid. Please enter a valid email.';
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
    case 'provider-already-linked':
      return 'The account is already linked with another provider.';
    case 'requires-recent-login':
      return 'This operation is sensitive and requires recent authentication. Please log in again.';
    case 'credential-already-in-use':
      return 'This credential is already associated with a different user account.';
    case 'account-exists-with-different-credential':
      return 'An account already exists with the same email but different sign-in credentials.';
    case 'supplied-credentials-do-not-correspond-to-the-previously-signed-in-user':
      return 'The supplied credentials do not correspond to the previously signed in credentials.';
    case 'operation-not-allowed':
      return 'This operation is not allowed. Contact support for assistance.';
    case 'expired-action-code':
      return 'The action code has expired. Please request a new action code.';
    case 'invalid-action-code':
      return 'The action code is invalid. Please check the code and try again.';
    case 'missing-action-code':
      return 'The action code is missing. Please provide a valid action code.';
    case 'user-token-expired':
      return 'The user\'s token has expired, and authentication is required. Please sign in again.';
    case 'missing-app-credential':
      return 'The app credential is missing. Please provide valid app credentials.';
    case 'session-cookie-expired':
      return 'The Firebase session cookie has expired. Please sign in again.';
    case 'uid-already-exists':
      return 'The provided user ID is already in use by another user.';
    case 'web-storage-unsupported':
      return 'Web storage is not supported or is disabled.';
    case 'app-deleted':
      return 'This instance of FirebaseApp has been deleted.';
    case 'user-token-mismatch':
      return 'The provided user\'s token has a mismatch with the authenticated user\'s user ID.';
    case 'invalid-message-payload':
      return 'The email template verification message payload is invalid.';
    case 'invalid-sender':
      return 'The email template sender is invalid. Please verify the sender\'s email.';
    case 'invalid-recipient-email':
      return 'The recipient email address is invalid. Please provide a valid recipient email.';
    case 'missing-iframe-start':
      return 'The email template is missing the iframe start tag.';
    case 'missing-iframe-end':
      return 'The email template is missing the iframe end tag.';
    case 'missing-iframe-src':
      return 'The email template is missing the iframe src attribute.';
    case 'auth-domain-config-required':
      return 'The authDomain configuration is required for the action code verification link.';
    default:
      return 'An unexpected Firebase error occurred. Please try again.';
  }
}

}




  // String get message {
  //   switch (code) {
  //     case 'permission-denied':
  //       return 'You do not have permission to access this resource.';
  //     case 'unauthenticated':
  //       return 'You must be authenticated to perform this action.';
  //     case 'user-not-found':
  //       return 'No user found with this email or ID.';
  //     case 'email-already-in-use':
  //       return 'This email is already in use by another account.';
  //     case 'wrong-password':
  //       return 'The password is incorrect. Please try again.';
  //     case 'weak-password':
  //       return 'The password is too weak. Please choose a stronger one.';
  //     case 'network-request-failed':
  //       return 'A network error occurred. Please check your internet connection.';
  //     case 'invalid-verification-code':
  //       return 'The verification code is invalid or expired.';
  //     case 'invalid-verification-id':
  //       return 'The verification ID is invalid or expired.';
  //     case 'quota-exceeded':
  //       return 'You have exceeded your quota. Try again later.';
  //     case 'too-many-requests':
  //       return 'Too many requests. Please wait and try again.';
  //     case 'operation-not-allowed':
  //       return 'This operation is not allowed. Contact support if you believe this is a mistake.';
  //     case 'invalid-email':
  //       return 'The email address is not valid.';
  //     case 'account-exists-with-different-credential':
  //       return 'An account already exists with a different credential.';
  //     case 'session-expired':
  //       return 'Your session has expired. Please sign in again.';
  //     case 'user-disabled':
  //       return 'This user account has been disabled by an administrator.';
  //     case 'missing-email':
  //       return 'An email address is required.';
  //     case 'invalid-credential':
  //       return 'The credential provided is incorrect or expired.';
  //     case 'provider-already-linked':
  //       return 'This account is already linked with another provider.';
  //     case 'credential-already-in-use':
  //       return 'This credential is already associated with a different user account.';
  //     case 'requires-recent-login':
  //       return 'This operation requires a recent login. Please sign in again and try.';
  //     case 'timeout':
  //       return 'The request has timed out. Please try again later.';
  //     case 'internal-error':
  //       return 'An internal Firebase error occurred. Please try again.';
  //     default:
  //       return 'An unexpected Firebase error occurred.';
  //   }
  // }