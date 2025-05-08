import 'package:dio/dio.dart';
import 'package:ecommerce_app_client/global/constants/apiConstant.dart';

class DioHelper {
  DioHelper._();

  static DioHelper? diohelper;

  Dio _dio = Dio(BaseOptions(baseUrl: ApiConstant.baseUrl,
  headers: {"apikey":ApiConstant.supabaseKey
  ,
  
    'Content-Type': 'application/json',
        'Accept': 'application/json',
  
  }  ,)
  
  
  );

  static DioHelper get instance {
    diohelper ??= DioHelper._();
    return diohelper!;
  }

  Future<Response> getRequest({required String url,     Map<String, dynamic>? queryParameters, Map<String, dynamic>? data, }) async {

    return await _dio.get(url, queryParameters: queryParameters , data: data);
  }

  Future<Response<dynamic>> postRequest(
      {required String url , Map<String, dynamic>? data, Options? option ,  Map<String, dynamic>? queryParameters }) async {
    return await _dio.post(url , data: data, options: option , queryParameters: queryParameters);
  }


  
  Future<Response> patchRequest(
      {required String url ,required Map<String, dynamic> data}) async {
    return await _dio.patch(url , data: data);
  }

    Future<Response> deleteRequest({required String url}) async {

    return await _dio.delete(url);
  }
}
