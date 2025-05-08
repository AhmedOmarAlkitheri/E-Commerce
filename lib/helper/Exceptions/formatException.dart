// Custom exception class to handle various format-related errors.
class FormatExcept implements Exception {
  final String message;

  // Default constructor with a generic error message.
  const FormatExcept(
      [this.message =
          'An unexpected format error occurred. Please check your input.']);

  // Factory to create a FormatExcept from a specific error message.
  factory FormatExcept.fromMessage(String message) {
    return FormatExcept(message);
  }

  // Get the corresponding error message.
  String get formattedMessage => message;

  // Factory to create a FormatExcept from a specific error code.
  factory FormatExcept.fromErrorCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const FormatExcept(
            'The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const FormatExcept(
            'The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const FormatExcept(
            'The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const FormatExcept(
            'The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const FormatExcept(
            'The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const FormatExcept(
            'The input should be a valid numeric format.');
      // Add more cases as needed...
      default:
        return const FormatExcept();
    }
  }
}









// class FormatExcept implements Exception {

//   final String code;


//   FormatExcept(this.code);


//   String get message {
//     switch (code) {
//       case 'INVALID_NUMBER':
//         return 'The provided number format is invalid. Please enter a valid number.';
//       case 'INVALID_DATE':
//         return 'The provided date format is incorrect. Use the correct date format.';
//       case 'INVALID_JSON':
//         return 'The provided JSON format is invalid. Please check the JSON syntax.';
//       case 'NULL_VALUE':
//         return 'A required value is missing. Please provide a valid input.';
//       case 'INVALID_EMAIL':
//         return 'The email format is incorrect. Please enter a valid email address.';
//       case 'INVALID_URL':
//         return 'The URL format is invalid. Please enter a valid URL.';
//       case 'EMPTY_STRING':
//         return 'The input cannot be an empty string.';
//       case 'OUT_OF_RANGE':
//         return 'The value is out of the allowed range.';
//       default:
//         return 'An unexpected format error occurred.';
//     }
//   }


// }
