import 'package:EfiritRetail/pages/Store/store_page.dart';
import 'package:EfiritRetail/store/models/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageCtrl extends GetxController {
  var page = 0.obs;
  var controller = PageController().obs;
  RxList<MenuItemModel> menuItems = <MenuItemModel>[
    MenuItemModel('Торговые точки', Icons.store, 'store/store/get', StorePage()),
    MenuItemModel('Пользователи', Icons.group, 'store/store/get', StorePage()),
    MenuItemModel('Товары и услуги', Icons.cached, 'store/store/get', StorePage()),
    MenuItemModel('Контрагенты', Icons.groups, 'store/store/get', StorePage()),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    controller.value.addListener(() {
      if (controller.value.page?.round() != page.value) {
        page.value = controller.value.page!.round();
        update();
      }
    });
  }

  onPageChanged(int input, {bool fast = false}) {
    controller.value.animateToPage(input, duration: Duration(milliseconds: fast ? 50 : 200), curve: Curves.easeIn);
  }

  setPage(int index) {
    page.value = index;
    update();
  }

  resetController(int page) {
    controller.value = PageController(initialPage: page);
  }
}