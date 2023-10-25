import 'package:EfiritRetail/pages/Store/store_page.dart';
import 'package:EfiritRetail/store/controllers/home_page.dart';
import 'package:EfiritRetail/store/models/pages.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenu extends StatelessWidget {
  MainMenu({Key? key}) : super(key: key);
  final HomePageCtrl homePageCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: homePageCtrl.menuItems.length,
        itemBuilder: (context, index) => MainMenuItem(homePageCtrl.menuItems[index]));
  }
}

class MainMenuItem extends StatelessWidget {
  final MenuItemModel item;

  const MainMenuItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Theme.of(context).canvasColor,
      closedColor: Theme.of(context).canvasColor,
      openElevation: 0,
      closedElevation: 0,
      closedBuilder: (BuildContext context, void Function() action) =>
          Card(child: ListTile(leading: Icon(item.icon), title: Text(item.title))),
      openBuilder: (BuildContext context, void Function({Object? returnValue}) action) => item.page,
    );
  }
}
