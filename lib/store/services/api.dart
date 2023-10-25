import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:EfiritRetail/config.dart';
import 'package:EfiritRetail/store/controllers/auth.dart';
import 'package:EfiritRetail/utils.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  final FlutterSecureStorage fss = const FlutterSecureStorage();
  final AuthCtrl _authCtrl = Get.find();

  @override
  void onInit() async {
    super.onInit();
    httpClient.baseUrl = AppConfig.APP_URL;
    httpClient.timeout = const Duration(seconds: 2);
    httpClient.maxAuthRetries = 3;
    httpClient.followRedirects = true;

    httpClient.addAuthenticator<dynamic>((request) async {
      try {
        bool isSuccess = await _authCtrl.tryRefreshToken();
        if (isSuccess) {
          String? token = await _authCtrl.getToken();
          request.headers['Authorization'] = 'Bearer $token';
        }
      } catch (err, _) {
        log('err ${err.toString()}');
      }
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      if ([401, 403].contains(response.statusCode)) {
        return Response(request: request, statusCode: 401);
      }
      if (response.hasError) {
        log(response.body.hasData ? '${response.body}' : '${response.statusText}');
        messageSnack(
            title:
                'Код ошибки: ${response.statusCode}\nТекст: ${response.body.hasData ? '${response.body}' : '${response.statusText}'}',
            isSuccess: false);
      }
      return response;
    });

    httpClient.addRequestModifier<dynamic>((request) async {
      String? token = await _authCtrl.getToken();
      request.headers['Content-type'] = 'application/json';
      if (_authCtrl.isAuth.hasData & _authCtrl.isAuth!) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, bool useLoading = false}) async {
    try {
      if (useLoading) loadingSnack();
      Response response = await get(uri, query: {..._authCtrl.settings, ...?query});
      if (useLoading) await Get.closeCurrentSnackbar();
      return response;
    } catch (e) {
      messageSnack(title: e.toString(), isSuccess: false);
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, Map<String, dynamic> data,
      {Map<String, dynamic>? query, bool useLoading = false}) async {
    try {
      if (useLoading) loadingSnack();
      Response response = await post(uri, data, query: {..._authCtrl.settings, ...?query});
      if (useLoading) await Get.closeCurrentSnackbar();
      return response;
    } catch (e) {
      messageSnack(title: e.toString(), isSuccess: false);
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> patchData(String uri, Map<String, dynamic> data, {Map<String, dynamic>? query}) async {
    try {
      Response response = await patch(uri, data, query: {..._authCtrl.settings, ...?query});
      return response;
    } catch (e) {
      messageSnack(title: e.toString(), isSuccess: false);
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri, {Map<String, dynamic>? query}) async {
    loadingSnack();
    try {
      Response response = await delete(uri, query: {..._authCtrl.settings, ...?query});
      return response;
    } catch (e) {
      messageSnack(title: e.toString(), isSuccess: false);
      return Response(statusCode: 1, statusText: e.toString());
    } finally {
      await Get.closeCurrentSnackbar();
    }
  }

// Future<d.Response> uploadFile(String uri, String filePath) async {
//   loadingSnack();
//   try {
//     d.Dio dio = d.Dio();
//     dio.options.headers['Authorization'] = _mainHeaders['Authorization'];
//     d.MultipartFile file = await d.MultipartFile.fromFile(filePath);
//     d.Response response =
//         await dio.post('$baseUrl$uri', data: d.FormData.fromMap({'avatar': file}));
//     await Get.closeCurrentSnackbar();
//     return response;
//   } catch (e) {
//     return d.Response(
//         requestOptions: d.RequestOptions(path: '$baseUrl$uri'),
//         statusCode: 1,
//         statusMessage: e.toString());
//   } finally {
//     await Get.closeCurrentSnackbar();
//   }
// }
}
