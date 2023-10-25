import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageCtrl extends GetxController {
  var page = 0.obs;
  var controller = PageController().obs;

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