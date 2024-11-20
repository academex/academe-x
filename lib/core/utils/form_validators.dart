class FormValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    if (value.length < 2) {
      return 'يجب أن يحتوي الاسم على حرفين على الأقل';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'اسم المستخدم مطلوب';
    }
    if (value.length < 3) {
      return 'يجب أن يحتوي اسم المستخدم على 3 أحرف على الأقل';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'اسم المستخدم يجب أن يحتوي على أحرف وأرقام وشرطة سفلية فقط';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    }
    if (!RegExp(r'^[0-9]{9}$').hasMatch(value)) {
      return 'رقم الهاتف يجب أن يتكون من 9 أرقام';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تحتوي على 6 أحرف على الأقل';
    }
    // if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(value)) {
    //   return 'كلمة المرور يجب أن تحتوي على أحرف وأرقام';
    // }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (value != password) {
      return 'كلمات المرور غير متطابقة';
    }
    return null;
  }
}