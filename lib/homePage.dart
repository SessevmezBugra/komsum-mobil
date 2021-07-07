import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';
import 'package:komsum/geography/widget/geographyFilterListWidget.dart';
import 'package:komsum/helper/common/appbar.dart';
import 'package:komsum/helper/common/filterbar.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/bloc/list/tagListBarrel.dart';
import 'package:komsum/tag/widget/tagFilterListWidget.dart';

import 'geography/bloc/list/geographyListBarrel.dart';
import 'helper/common/sidebar.dart';
import 'helper/common/subheader.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GeographyListBloc>(
          create: (BuildContext context) =>
              GeographyListBloc(httpClient: http.Client())
                ..add(GeographyCityListLoad()),
        ),
        BlocProvider<TagListBloc>(
          create: (BuildContext context) =>
              TagListBloc(httpClient: http.Client())..add(TagListLoad()),
        ),
        BlocProvider<TagFilterBloc>(
          create: (BuildContext context) => TagFilterBloc(),
        ),
        BlocProvider<GeographyFilterBloc>(
          create: (BuildContext context) => GeographyFilterBloc(),
        )
      ],
      child: Scaffold(
        key: _scaffoldKey,
        drawer: SidebarMenu(),
        body: CustomScrollView(
          slivers: [
            AppBarWidget(text: "Komsum"),
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                minHeight: 50,
                maxHeight: 60,
                child: FittedBox(
                  child: Column(
                    children: [
                      TagFilterList(),
                      GeographyFilterList()
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
