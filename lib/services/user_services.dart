import 'package:app_transport/services/dio_services.dart';
import 'package:app_transport/shared/helper/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static final DioServices _dioService = DioServices();
  static Future<dynamic> signIn(String phone, String password) async {
    final data = {
      'phone': phone,
      'password': password,
    };
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await _dioService.post(endPoint: 'sign-in', data: data);

    if (response.statusCode == 200) {
      var res = response.data;
      await prefs.setString("token", res['token'].toString());
    } else {
      logger.w("Login fail");
    }
  }

  static Future<dynamic> getMe() async {
    final response = await _dioService.get(
      endPoint: 'me',
    );
    if (response.statusCode == 200) {
      var res = response.data;
      return res;
    } else {
      logger.w("get user fail");
    }
  }

  static Future<dynamic> signUp(String phone, String password) async {
    final data = {
      'phone': phone,
      'password': password,
    };
    final response = await _dioService.post(endPoint: 'sign-up', data: data);
    if (response.statusCode == 200) {
      logger.w('Đăng ký thành công');
    } else {
      logger.w("sign up fail");
    }
  }
}
