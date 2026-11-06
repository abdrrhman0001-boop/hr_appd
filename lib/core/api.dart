// طبقة الربط مع نظام HR الحالي عبر REST — تُستبدل الـ baseUrl بالحقيقي
// + تشفير: تُخزَّن الرموز في flutter_secure_storage، والاتصال عبر HTTPS فقط.
// + Push: سجّل FCM token هنا. + Audit: كل عملية حساسة تُسجَّل في AppStore.log
import 'package:dio/dio.dart';
class HrApi {
  final Dio dio;
  HrApi({String baseUrl = 'https://hr.company.dz/api/v1'})
      : dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 10)));
  Future<void> submitLeave(Map<String,dynamic> body) async {
    // await dio.post('/leaves', data: body);
    await Future.delayed(const Duration(milliseconds: 400)); // وضع تجريبي دون إنترنت
  }
}
