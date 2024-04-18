
import 'package:dio/dio.dart';
import 'package:mham/core/constent/api_constant.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? query,
    required String lang,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      if (token != null) 'authorization': token,
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required url,
        Map<String, dynamic>? data,
        required String lang ,
        String? token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      if (token != null) 'authorization': token,
    };
    return await dio!.post(url, data: data);
  }

  static Future<Response> putData(
      {required url,
        required Map<String, dynamic> data,
        required String lang,
        String? token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      if (token != null) 'authorization': token,
    };
    return await dio!.put(url, data: data);
  }

  static Future<Response> patchData({
    required url,
    Map<String, dynamic>? data,
    required String lang,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      if (token != null) 'authorization': token,
    };
    return await dio!.patch(url,data: data);
  }


  static Future<Response> deleteData({
    required url,
    required String lang,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      if (token != null) 'authorization': token,
    };
    return await dio!.delete(url,queryParameters: query);
  }

}