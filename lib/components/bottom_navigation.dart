import 'package:app_transport/controllers/navigation_controller.dart';
import 'package:app_transport/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  NavigationController _navigationController = Get.put(NavigationController());
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    _navigationController.updateSelectIndex(index);
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Get.toNamed("");
        break;
      case 1:
        Get.toNamed('profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Danh mục',
        ),
      ],
      currentIndex: _navigationController.selectIndex,
      selectedItemColor: Colors.red[800],
      onTap: _onItemTapped,
    );
  }
}
