import 'dart:developer';

import 'package:EfiritRetail/utils.dart';
import 'package:get/get.dart';
import 'package:EfiritRetail/config.dart';

class AuthService extends GetConnect implements GetxService {
  final String appUrl = AppConfig.APP_URL + AppConfig.AUTH_PORT;

  @override
  void onInit() async {
    super.onInit();
    httpClient.baseUrl = appUrl;
    httpClient.timeout = const Duration(seconds: 2);
    httpClient.addRequestModifier<dynamic>((request) async {
      request.headers['Content-type'] = 'application/json';
      return request;
    });
    httpClient.addResponseModifier((request, response) {
      if (response.hasError) {
        log(response.body.hasData ? '${response.body}' : '${response.statusText}');
        messageSnack(
            title:
                'Код ошибки: ${response.statusCode}\nТекст: ${response.body.hasData ? '${response.body}' : '${response.statusText}'}',
            isSuccess: false);
      }
      return response;
    });
  }

  void switchBaseUrl(bool isOwner) {
    httpClient.baseUrl = appUrl +(isOwner ? '/auth/owner' : '/auth/worker');
  }

  Future<Response> tryLoginIn(Map<String, dynamic> values, {Map<String, dynamic>? query}) async {
    Response resp = await post('/login', values, query: query);
    return resp;
  }

  Future<Response> tryRefreshToken(String refreshToken) async {
    Map<String, String> headers = {'Authorization': 'Bearer $refreshToken'};
    Response resp = await post('/refresh', {}, headers: headers);
    return resp;
  }

  Future<Response> tryRegistration(Map<String, dynamic> postData) async {
    Response resp = await post('/create', postData);
    return resp;
  }

  Future<Response> getOrganization(Map<String, String> headers, Map<String, dynamic> query) async {
    var url = httpClient.baseUrl;
    httpClient.baseUrl = AppConfig.APP_URL + AppConfig.ORG_PORT;
    Response resp = await get('/org/org/getList',headers: headers, query: query);
    httpClient.baseUrl = url;
    return resp;
  }

  Future<void> logout() async {}
}
