import 'package:app_transport/services/dio_services.dart';
import 'package:app_transport/shared/helper/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransportServices {
  static final DioServices _dioService = DioServices();

  static Future<dynamic> getListDelivery(String status) async {
    final response = await _dioService
        .get(endPoint: 'transport/delivery', params: {"status": status});
    if (response.statusCode == 200) {
      var res = response.data;
      return res['data'];
    } else {
      logger.w("get user fail");
    }
  }

  static Future<bool> changeStatus(String id, String target, int status) async {
    final data = {"status": status, 'target': target, 'id': id};
    final response =
        await _dioService.post(endPoint: 'transport/status', data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      logger.w("get user fail");
      return false;
    }
  }
}
