import 'package:app_transport/components/bottom_navigation.dart';
import 'package:app_transport/controllers/auth_controller.dart';
import 'package:app_transport/screens/profile/widgets/setting_profile.dart';
import 'package:app_transport/services/user_services.dart';
import 'package:app_transport/shared/helper/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenWidget extends StatefulWidget {
  const ProfileScreenWidget({super.key});

  @override
  State<ProfileScreenWidget> createState() => _ProfileScreenWidgetState();
}

class _ProfileScreenWidgetState extends State<ProfileScreenWidget> {
  final UserController _userController = Get.put(UserController());

  void getMe() async {
    try {
      var res = await UserServices.getMe();
      if (res['name'] != '') {
        setState(() {
          _userController.updateInfor(res);
        });
      }
    } catch (e) {
      logger.w(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavigationWidget(),
      body: GetBuilder<UserController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background_profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage(_userController
                                    .infor['avatar'] ??
                                'https://viettelpost.com.vn/wp-content/uploads/2021/03/660x800.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(70.0)),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                      Text(
                        _userController.infor['name '] ?? 'Vũ Tiến Đạt',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Mã NV:' + _userController.infor['code'] ??
                            '437211-HN10',
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SettingProfileWidget()
              ],
            ),
          );
        },
      ),
    );
  }
}
