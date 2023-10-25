import 'package:EfiritRetail/config.dart';
import 'package:EfiritRetail/store/services/api.dart';
import 'package:get/get.dart';

class OrganizationService extends GetxService {
  final ApiClient _apiClient = Get.find();

  Future<Response> getOrganizations() async {
    Response resp = await _apiClient.getData('${AppConfig.ORG_PORT}/org/org/getList');
    return resp;
  }

  Future<Response> createOrganization(Map<String, dynamic> data) async {
    Response resp = await _apiClient.postData('${AppConfig.ORG_PORT}/org/org/create', data);
    return resp;
  }
}