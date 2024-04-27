import 'dart:io';
import 'package:app_transport/app/app_globals.dart';
import 'package:app_transport/shared/helper/logger.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioServices {
  static Dio dio = Dio();
  DioService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token') ?? '';
          String tokenDevice = prefs.getString('tokenDevice') ?? "";
          // Add the access token to the request header
          options.headers['Authorization'] = 'Bearer $token';
          options.headers['device-token'] = tokenDevice;

          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // if (e is DioError) {
          //   // Kiểm tra xem có phải lỗi kết nối không
          //   if (e.error is DioErrorType) {
          //     // Hiển thị thông báo lỗi
          //     print('Lỗi kết nối: Không có đường đi đến máy chủ.');
          //   } else {
          //     showSnackBarError(e.toString());
          //   }
          // } else {
          //   logger.w(123);
          //   if (e.response!.data['data']['message'] != '') {
          //     showSnackBarError(e.response!.data['data']['message']);
          //   }
          // }
          // if (e.error is Object) {
          //   print('Lỗi kết nối: Không có đường đi đến máy chủ.');
          // } else {
          //   logger.w(e);
          //   showSnackBarError(e.toString());
          //   return handler.reject(e);
          // }

          // if (e.response?.statusCode == 401) {
          //   final SharedPreferences prefs =
          //       await SharedPreferences.getInstance();
          //   var token = prefs.getString('refreshToken') ?? '';
          //   // If a 401 response is received, refresh the access token
          //   String newAccessToken = await AuthServices.postRefresh(token);

          //   // Update the request header with the new access token
          //   e.requestOptions.headers['Authorization'] =
          //       'Bearer $newAccessToken';

          //   // Repeat the request with the updated header
          //   return handler.resolve(await dio.fetch(e.requestOptions));
          // }
          return handler.next(e);
        },
      ),
    );
    const bool kReleaseMode = bool.fromEnvironment('dart.vm.product');
    const bool kProfileMode = bool.fromEnvironment('dart.vm.profile');
    const bool kDebugMode = !kReleaseMode && !kProfileMode;
    if (!kTestMode) {
      dio.options = dioBaseOptions;
      if (kDebugMode) {
        dio.interceptors
            .add(LogInterceptor(requestBody: true, responseBody: true));
      }
    }
  }

  @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
      };
  @override
  String get baseUrl => dotenv.env['API_URL'] ?? '';
  BaseOptions get dioBaseOptions => BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30));

  Future<Response> get(
      {required String endPoint, dynamic data, dynamic params}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? '';
    final options = Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    var response = await dio.get('$baseUrl/$endPoint',
        data: data, queryParameters: params, options: options);
    return response;
  }

  Future<Response> post(
      {required String endPoint,
      dynamic data,
      dynamic params,
      dynamic option}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? '';
    final options = Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    var response = await dio.post('$baseUrl/$endPoint',
        data: data, queryParameters: params, options: options);
    return response;
  }

  Future<Response> put(
      {required String endPoint,
      dynamic data,
      dynamic params,
      dynamic option}) async {
    var response = await dio.put('$baseUrl/$endPoint',
        data: data, queryParameters: params, options: option);
    return response;
  }

  Future<Response> delete({required String endPoint}) async {
    var response = await dio.delete('$baseUrl/$endPoint');
    return response;
  }
}
