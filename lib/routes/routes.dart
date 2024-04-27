import 'package:app_transport/screens/home/home_screen.dart';
import 'package:app_transport/screens/login/login_screen.dart';
import 'package:app_transport/screens/profile/profile_screen.dart';
import 'package:app_transport/screens/register/register_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const initial = '/login';
  static final routes = [
    GetPage(name: "/", page: () => const HomeScreenWidget()),
    GetPage(name: "/login", page: () => const LoginScreenWidget()),
    GetPage(name: "/register", page: () => const RegisterScreenWidget()),
    GetPage(name: "/profile", page: () => const ProfileScreenWidget()),
  ];
}
