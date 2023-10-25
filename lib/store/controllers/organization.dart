import 'package:EfiritRetail/store/models/organization.dart';
import 'package:EfiritRetail/store/services/api.dart';
import 'package:EfiritRetail/store/services/organization.dart';
import 'package:get/get.dart';

class OrganizationCtrl extends GetxController {
  final OrganizationService _organizationService = Get.put(OrganizationService());
  RxList<ShortOrganization> orgs = <ShortOrganization>[].obs;
  Rx<Organization> org = Organization().obs;


  void getOrganizations() async {
    Response resp = await _organizationService.getOrganizations();
    if (!resp.hasError) {
      var respOrgs = resp.body['organizations'];
      if (respOrgs.isNotEmpty) {
        orgs.value = respOrgs.map<ShortOrganization>((val) => ShortOrganization.fromJson(val)).toList();
      }
    }
  }

  void createOrganization(Map<String, dynamic> data) async {
    Response resp = await _organizationService.createOrganization(data);
    if (!resp.hasError) {
      org.value = Organization.fromJson(resp.body);
    }
  }
}
