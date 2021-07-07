import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/geography/bloc/filter/geographyFilterState.dart';
import 'package:komsum/geography/widget/geographyListWidget.dart';
import 'package:komsum/tag/widget/tagListWidget.dart';

import 'filterbar.dart';

class SidebarMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SiderbarMenuState();
  }
}

class _SiderbarMenuState extends State<SidebarMenu>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 35),
            child: FilterBar(),
          ),
          Container(
            margin: EdgeInsets.only(top: 35),
            child: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Text(
                      "Bolgeler",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      "Basliklar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                GeographyListWidget(),
                TagListWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
