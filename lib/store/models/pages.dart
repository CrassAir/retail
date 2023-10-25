import 'package:flutter/material.dart';

class MenuItemModel {
  String title;
  IconData icon;
  String validate;
  Widget page;

  MenuItemModel(this.title, this.icon, this.validate, this.page);
}