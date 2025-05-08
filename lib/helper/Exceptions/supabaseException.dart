class SupabaseExcept implements Exception {
  final String code;
  final String? customMessage;

  SupabaseExcept(this.code, [this.customMessage]);

  String get message {
    if (customMessage != null) {
      return customMessage!;
    }

    switch (code) {
      // ✅ مصادقة (Auth) - الأخطاء المتعلقة بالمستخدمين والتسجيل
     
       
          case  'invalid_credentials':
        return 'البريد الإلكتروني أو كلمة المرور غير صحيحة. يرجى المحاولة مرة أخرى.';
      case 'invalid_signup':
        return 'طلب التسجيل غير صالح. يرجى التحقق من التفاصيل المقدمة.';
      case 'user_not_found':
        return 'لم يتم العثور على مستخدم بهذا البريد الإلكتروني. يرجى التسجيل أولاً.';
      case 'email_already_exists':
        return 'البريد الإلكتروني مستخدم بالفعل. يرجى تسجيل الدخول بدلاً من ذلك.';
      case 'email_change_disabled':
        return 'تغيير البريد الإلكتروني معطل لهذا المستخدم.';
      case 'unauthorized':
        return 'غير مصرح لك بتنفيذ هذا الإجراء.';
      case 'user_disabled':
        return 'تم تعطيل حسابك. يرجى الاتصال بالدعم للمساعدة.';
      case 'invalid_token':
        return 'رمز المصادقة غير صالح. يرجى تسجيل الدخول مرة أخرى.';
      case 'token_expired':
        return 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.';
      case 'invalid_refresh_token':
        return 'رمز التحديث غير صالح. يرجى تسجيل الدخول مرة أخرى.';
      case 'email_link_invalid':
        return 'رابط البريد الإلكتروني غير صالح أو انتهت صلاحيته.';
      case 'email_link_expired':
        return 'انتهت صلاحية رابط البريد الإلكتروني. يرجى طلب رابط جديد.';
      case 'email_link_already_used':
        return 'تم استخدام رابط البريد الإلكتروني بالفعل. يرجى تسجيل الدخول.';
      case 'rate_limit_exceeded':
        return 'تم تجاوز عدد الطلبات المسموح بها. يرجى المحاولة مرة أخرى لاحقاً.';
      case 'verification_required':
        return 'مطلوب التحقق من البريد الإلكتروني. يرجى التحقق من صندوق الوارد.';
      case 'duplicate_refresh_token':
        return 'تم اكتشاف رمز تحديث مكرر. يرجى تسجيل الدخول مرة أخرى.';
      case 'restricted_operation':
        return 'هذه العملية مقيدة. يرجى الاتصال بالدعم.';

      // ✅ قاعدة البيانات (Database) - أخطاء الاستعلامات والبيانات
      case 'db_record_not_found':
        return 'لم يتم العثور على السجل المطلوب في قاعدة البيانات.';
      case 'db_unique_violation':
        return 'يوجد بالفعل سجل بهذه القيمة.';
      case 'db_foreign_key_violation':
        return 'لا يمكن حذف هذا السجل لأنه مرتبط بسجلات أخرى.';
      case 'db_connection_failed':
        return 'فشل الاتصال بقاعدة البيانات. يرجى المحاولة مرة أخرى لاحقاً.';
      case 'db_invalid_query':
        return 'استعلام قاعدة البيانات غير صالح.';
      case 'db_permission_denied':
        return 'ليس لديك إذن للوصول إلى هذه البيانات.';
      case 'db_rate_limit_exceeded':
        return 'تم تجاوز عدد الطلبات المسموح بها لقاعدة البيانات. يرجى التباطؤ.';

      // ✅ التخزين (Storage) - أخطاء إدارة الملفات
      case 'storage_bucket_not_found':
        return 'مجلد التخزين المحدد غير موجود.';
      case 'storage_unauthorized':
        return 'غير مصرح لك بالوصول إلى هذا الملف.';
      case 'storage_file_not_found':
        return 'لم يتم العثور على الملف المطلوب.';
      case 'storage_invalid_path':
        return 'مسار الملف المحدد غير صالح.';
      case 'storage_invalid_file':
        return 'الملف الذي تم تحميله غير صالح أو تالف.';
      case 'storage_upload_failed':
        return 'فشل تحميل الملف. يرجى المحاولة مرة أخرى.';
      case 'storage_delete_failed':
        return 'فشل حذف الملف. يرجى التحقق من الأذونات.';
      case 'storage_quota_exceeded':
        return 'تم تجاوز سعة التخزين المسموح بها. يرجى تحرير مساحة.';

      // ✅ API - أخطاء الوصول والتصاريح
      case 'api_unauthorized':
        return 'غير مصرح لك بالوصول إلى هذا المورد.';
      case 'api_forbidden':
        return 'الوصول إلى هذا المورد ممنوع.';
      case 'api_not_found':
        return 'لم يتم العثور على نقطة النهاية المطلوبة.';
      case 'api_method_not_allowed':
        return 'طريقة HTTP هذه غير مسموح بها لهذه النقطة.';
      case 'api_rate_limit_exceeded':
        return 'تم تجاوز عدد الطلبات المسموح بها. يرجى التباطؤ.';
      case 'api_internal_error':
        return 'حدث خطأ داخلي في الخادم. يرجى المحاولة مرة أخرى لاحقاً.';
      case 'api_bad_request':
        return 'طلب غير صالح. يرجى التحقق من المدخلات.';

      // ✅ WebSocket - أخطاء الاتصال المباشر مع Supabase
      case 'ws_connection_failed':
        return 'فشل الاتصال بـ WebSocket.';
      case 'ws_disconnected':
        return 'تم فقدان الاتصال بـ WebSocket. جارٍ إعادة الاتصال...';
      case 'ws_timeout':
        return 'انتهت مهلة طلب WebSocket. يرجى المحاولة مرة أخرى.';
      case 'ws_unauthorized':
        return 'اتصال WebSocket غير مصرح به.';

      // ✅ أخطاء عامة
      case 'network_error':
        return 'خطأ في الشبكة. يرجى التحقق من اتصال الإنترنت.';
      case 'unexpected_error':
        return 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى لاحقاً.';
      default:
        return 'حدث خطأ غير معروف في Supabase. يرجى الاتصال بالدعم.';
    }
  }
}