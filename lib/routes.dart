import 'package:EfiritRetail/pages/Auth/login_page.dart';
import 'package:EfiritRetail/pages/Auth/registration_page.dart';
import 'package:EfiritRetail/pages/Initial_page.dart';
import 'package:EfiritRetail/pages/home_page.dart';
import 'package:EfiritRetail/store/middlewares/auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class RouterHelper {
  static const home = '/';
  static const initial = '/initial';
  static const login = '/login';
  static const register = '/register';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const InitialPage(), transition: Transition.noTransition),
    GetPage(name: login, page: () => const LoginPage(), curve: Curves.easeIn, transition: Transition.downToUp),
    GetPage(name: register, page: () => const RegistrationPage()),
    GetPage(
        name: home,
        page: () => const HomePage(),
        curve: Curves.easeIn,
        transition: Transition.topLevel,
        middlewares: [AuthMiddleware()]),
  ];
}
