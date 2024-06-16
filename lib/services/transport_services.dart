import 'package:app_transport/services/dio_services.dart';
import 'package:app_transport/shared/helper/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransportServices {
  static final DioServices _dioService = DioServices();

  static Future<dynamic> getListDelivery(String status, String query) async {
    final response = await _dioService.get(
        endPoint: 'delivery',
        params: {"status": status, "q": query, "postCode": "122000"});
    if (response.statusCode == 200) {
      var res = response.data;
      return res['data'];
    } else {
      logger.w("get user fail");
    }
  }

  static Future<dynamic> getListReceive(String status, String query) async {
    final response = await _dioService.get(
        endPoint: 'receive',
        params: {"status": status, "q": query, "postCode": "122000"});
    if (response.statusCode == 200) {
      var res = response.data;
      return res['data'];
    } else {
      logger.w("get user fail");
    }
  }

  static Future<dynamic> getListRefund({String target = 'delivery'}) async {
    final response =
        await _dioService.get(endPoint: 'refund', params: {"target": target});
    if (response.statusCode == 200) {
      var res = response.data;
      return res['data'];
    } else {
      logger.w("get user fail");
    }
  }

  static Future<dynamic> postRefund(
      {String reason = '',
      String target = "delivery",
      String receiveInfor = "",
      String deliveryInfor = ""}) async {
    final data = deliveryInfor == ""
        ? {
            "reason": reason,
            "target": target,
            "receiveInfor": receiveInfor,
          }
        : {"reason": reason, "target": target, "deliveryInfor": deliveryInfor};
    final response = await _dioService.post(endPoint: 'refund', data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      logger.w("get user fail");
      return false;
    }
  }

  static Future<bool> changeStatus(String id, String target, int status) async {
    final data = {"status": status, 'target': target, 'id': id};
    final response =
        await _dioService.post(endPoint: 'change/transport', data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      logger.w("get user fail");
      return false;
    }
  }

  static Future<dynamic> listCall(String id, String target) async {
    final data = {'target': target, 'id': id};
    final response = await _dioService.get(endPoint: 'call', params: data);
    if (response.statusCode == 200) {
      var res = response.data;
      return res['data'];
    } else {
      logger.w("get call fail");
      return false;
    }
  }

  static Future<dynamic> getDetailDelivery(String id, String target) async {
    final response = await _dioService.get(
      endPoint: '/$target/id=$id',
    );
    if (response.statusCode == 200) {
      var res = response.data;
      return res['data'];
    } else {
      logger.w("get user fail");
    }
  }

  static Future<bool> changeAddressPost(
      dynamic item, String postCode, String target) async {
    final data = {...item, postCode: postCode};
    final response = await _dioService.put(endPoint: '$target', data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      logger.w("get user fail");
      return false;
    }
  }
}
