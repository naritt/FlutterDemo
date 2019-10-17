import 'package:flutter/material.dart';

class TabModel {
  final String title;
  final IconData icon;

  TabModel(this.title, this.icon);

  static List<TabModel> getInitialTabMenu(){
    List<TabModel> tabList = List<TabModel>();
    tabList.add(TabModel("TOP 100", Icons.view_list));
    tabList.add(TabModel("ALL", Icons.view_module));

    return tabList;
  }
}