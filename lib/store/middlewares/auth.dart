import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EfiritRetail/routes.dart';
import 'package:EfiritRetail/store/controllers/auth.dart';


class AuthMiddleware extends GetMiddleware {
  final AuthCtrl _authCtrl = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (_authCtrl.isAuth != null && !_authCtrl.isAuth!) {
      return const RouteSettings(name: RouterHelper.login);
    }
    return null;
  }
}