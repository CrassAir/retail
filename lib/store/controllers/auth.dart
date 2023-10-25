import 'dart:convert';
import 'dart:developer';

import 'package:EfiritRetail/routes.dart';
import 'package:EfiritRetail/store/controllers/organization.dart';
import 'package:EfiritRetail/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:EfiritRetail/store/models/auth.dart';
import 'package:EfiritRetail/store/services/auth.dart';

class AuthCtrl extends GetxController with StateMixin {
  final FlutterSecureStorage fss = FlutterSecureStorage(aOptions: getAndroidOptions());
  final AuthService authService = Get.put(AuthService());
  // final OrganizationCtrl organizationCtrl = Get.find();

  RxMap<String, dynamic> settings = <String, dynamic>{}.obs;
  bool? isAuth;
  User? user;
  int tryCount = 0;
  bool isOwner = false;

  @override
  void onInit() async {
    super.onInit();
    getDefaultQueries();
    change(null, status: RxStatus.success());
    await getToken();
    isOwner = await fss.read(key: 'isOwner') == 'true';
    setBaseUrl(isOwner);
    if (isAuth != null) {
      if (isAuth!) {
        await Get.offAllNamed(RouterHelper.home);
      } else {
        await Get.offAllNamed(RouterHelper.login);
      }
    }
  }

  void setBaseUrl(bool isOwner) {
    authService.switchBaseUrl(isOwner);
  }

  void getDefaultQueries() async {
    String? ownerId = await fss.read(key: 'ownerId');
    String? organizationId = await fss.read(key: 'organizationId');
    if (ownerId.hasData && organizationId.hasData) {
      settings.value = {'ownerId': ownerId!, 'organizationId': organizationId!};
    }
  }

  void setDefaultQueries(Map<String, dynamic> newSettings) async {
    await fss.write(key: 'ownerId', value: newSettings['ownerId']);
    await fss.write(key: 'organizationId', value: newSettings['organizationId']);
    settings.value = {...newSettings};
    update();
  }

  Future<String?> getToken() async {
    String? rawUser = await fss.read(key: 'user');
    if (rawUser.hasData) {
      user = User.fromJson(jsonDecode(rawUser!));
      isAuth = true;
    } else {
      isAuth = false;
    }
    return user?.accessToken;
  }

  Future<bool> tryRefreshToken() async {
    tryCount++;
    if (user.hasData) {
      String? refreshToken = user!.refreshToken;
      if (refreshToken.hasData) {
        Response resp = await authService.tryRefreshToken(refreshToken);
        if (resp.statusCode == 200) {
          user = User.fromJson(resp.body);
          await fss.write(key: 'user', value: user!.toJson().toString());
          return true;
        }
      }
    }
    if (tryCount >= 3) {
      logout();
    }
    return false;
  }

  void tryLoginIn(Map<String, dynamic> values, bool rIsOwner) async {
    change(user, status: RxStatus.loading());
    isOwner = rIsOwner;
    setBaseUrl(isOwner);
    Response resp = await authService.tryLoginIn(values, query: isOwner ? null : settings);
    if (resp.statusCode == 200) {
      user = User.fromJson(resp.body);
      if (user.hasData) {
        if (isOwner) {
          var resp = await authService.getOrganization({'Authorization': 'Bearer ${user!.accessToken}'},{'ownerId': user!.id});
          setDefaultQueries({'ownerId': user!.id, 'organizationId': resp.body['organizations'][0]['id']});
        }
        isAuth = true;
        await fss.write(key: 'user', value: user!.toJson().toString());
        await fss.write(key: 'isOwner', value: isOwner.toString());
        await Get.offAllNamed(RouterHelper.home);
      }
    }
    change(user, status: RxStatus.success());
  }

  void tryRegistration(Map<String, dynamic> userData, Map<String, dynamic> orgData) async {
    Response resp = await authService.tryRegistration(userData);
    log('${resp.body}');
    if (resp.statusCode == 200) {
      user = User.fromJson(resp.body);
      if (user.hasData) {
        await fss.write(key: 'user', value: user!.toJson().toString());
        await Get.offAllNamed(RouterHelper.home);
      }
    }
  }

  void logout() async {
    await fss.delete(key: 'user');
    await fss.delete(key: 'isOwner');
    user = null;
    isAuth = false;
    // await authService.logout();
    await Get.offAndToNamed(RouterHelper.login);
  }
}
