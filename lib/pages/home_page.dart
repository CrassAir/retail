import 'package:EfiritRetail/pages/main_menu.dart';
import 'package:EfiritRetail/store/controllers/auth.dart';
import 'package:EfiritRetail/store/controllers/home_page.dart';
import 'package:EfiritRetail/store/controllers/organization.dart';
import 'package:EfiritRetail/store/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  HomePageCtrl homePageCtrl = Get.put(HomePageCtrl());
  ApiClient apiClient = Get.put(ApiClient());
  OrganizationCtrl _organizationCtrl = Get.put(OrganizationCtrl());
  AuthCtrl authCtrl = Get.find();

  @override
  void initState() {
    super.initState();
    _organizationCtrl.getOrganizations();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onChangePage() {}

  @override
  Widget build(BuildContext context) {
    void handleLogout() {
      authCtrl.logout();
    }

    // for test create orgs and doesn't create user
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            pinned: true,
            // expandedHeight: 125.0,
            backgroundColor: Theme.of(context).primaryColor,
            // collapsedHeight: 80,
            actions: [IconButton(onPressed: handleLogout, icon: const Icon(Icons.logout))],
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(top: 30, bottom: 10),
              centerTitle: true,
              title: Text('Home'),
            )),
        MainMenu(),
      ],
    ));
  }
}
