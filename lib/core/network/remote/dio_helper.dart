import 'package:arboon/core/network/remote/end_points.dart';
import 'package:dio/dio.dart';


class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: ApiEndPoints.baseUrl,
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
          
          }),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? lang,
    String? token,
  }) async {
    dio!.options.headers = {
     
      'Authorization': token ?? '',
    };
    var res = await dio!.get(url, queryParameters: query);

    return res;
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? lang,
    String? token,
  }) async {
    dio!.options.headers = {
     
      'Authorization': token ?? '',
    };
    var res = await dio!.delete(url, queryParameters: query);

    return res;
  }

  static Future<Response> postData({
    required String url,
    dynamic data,
    String? lang,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
     
      'Authorization': token ?? '',
    };
    var res = await dio!.post(
      url,
      data: data,
      queryParameters: query,
    );

    return res;
  }
}



