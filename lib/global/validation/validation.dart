class InputValidator {
  static String? validateArabicName(String? value) {
    final regex = RegExp(r'^[\u0600-\u06FF\s]{1,30}$');
    final parts = value!.trim().split(' ');

    if (!regex.hasMatch(value) || value.isEmpty || parts.length <= 2) {
      return 'أدخل اسمك بالشكل المطلوب';
    }
    return null;
  }

static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
        return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
        return 'Invalid email address.';
    }
    return null;
}

static String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required.';
  }

  // Check for minimum password length
  if (value.length < 6) {
    return 'Password must be at least 6 characters long.';
  }

  // Check for uppercase letters
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter.';
  }

  // Check for numbers
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number.';
  }

  // Check for special characters
  if (!value.contains(RegExp(r'[!@#\$%\^&\*\(\)\.,\?:{}|<>]'))) {
    return 'Password must contain at least one special character.';
  }

  return null;
}
  // static String? validateGuardianName(String? value) {
  //   final regex = RegExp(r'^[\u0600-\u06FF\s]{1,30}$');
  //   final parts = value!.trim().split(' ');

  //   if (!regex.hasMatch(value) || value.isEmpty || parts.length < 3) {
  //     return 'أدخل اسم ولي امرك الثلاثي وما فوق بالشكل المطلوب';
  //   }
  //   return null;
  // }

  // static String? validateArabic(String? value) {
  //   final regex = RegExp(r'^[\u0600-\u06FF\s]+$');

  //   if (!regex.hasMatch(value!) || value.isEmpty) {
  //     return 'أدخل المحتوى المطلوب بشكل صحيح';
  //   }
  //   return null;
  // }

  // static String? validateNumbers(String? value) {
  //   final regex = RegExp(r'^\d+(\.\d+)?$');
  //   if (!regex.hasMatch(value!) || value.isEmpty) {
  //     return 'يجب أن يحتوي المدخل على نسبة آخر فصل دراسي فقط';
  //   }
  //   return null;
  // }

  static String? validatePhoneNumber(String? value) {
    final regex = RegExp(r'^(77|78|70|71|73)[0-9]{7}$'); 

  if (value == null || value.isEmpty) {
    return 'يرجى إدخال رقم الجوال';
  }

  if (!regex.hasMatch(value)) {
    return 'أدخل رقم جوالك بشكل صحيح';
  }
    return null;
  }

  // static String? validateMixedInput(String? value) {
  //   final regex = RegExp(r'^[\u0600-\u06FFa-zA-Z0-9\s!"(),.\/:;<>?\{}|~\-]+$');

  //   if (!regex.hasMatch(value!) || value.isEmpty) {
  //     return 'أدخل المحتوى بشكل صجيح';
  //   }
  //   return null;
  // }

  // static String? validateusername(String? value) {
  //   final regex = RegExp(r'^(77|78|70|71|73)[0-9]{7}$'); 

  // if (value == null || value.isEmpty) {
  //   return 'يرجى إدخال رقم الجوال';
  // }

  // if (!regex.hasMatch(value)) {
  //   return 'يجب أن يكون بداية الرقم 77 أو 78 أو 73 أو 70 أو 71';
  // }
  //   return null;
  // }



    static String? validateNotEmpty(String? value) {
   
    if (value == null || value.isEmpty) {
      return '';
    }
    return null;
  }
}
