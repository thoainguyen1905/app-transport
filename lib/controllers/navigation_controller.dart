import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt _selectIndex = 0.obs;
  final RxBool _disableNavigation = false.obs;

  get selectIndex => _selectIndex.value;
  get disableNavigation => _disableNavigation.value;

  void updateSelectIndex(int value) {
    _selectIndex.value = value;
    update();
  }

  void updateStatusNavigation(bool value) {
    _disableNavigation.value = value;
    update();
  }
}
