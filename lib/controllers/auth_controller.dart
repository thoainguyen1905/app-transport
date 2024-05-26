import 'package:app_transport/shared/helper/logger.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final RxMap<dynamic, dynamic> _infor = {}.obs;
  final RxInt _postIndex = 1.obs;
  get postIndex => _postIndex.value;
  get infor => _infor.value;

  void updateInfor(dynamic value) {
    _infor.addAll(value);
    update();
  }

  void updatePostIndex(int val) {
    _postIndex.value = val;
  }
}
