import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';
import 'package:komsum/geography/widget/geographyFilterListWidget.dart';
import 'package:komsum/helper/common/appbar.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/bloc/list/postListBarrel.dart';
import 'package:komsum/post/model/post.dart';
import 'package:komsum/post/widget/postListWidget.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/widget/tagFilterListWidget.dart';

import 'helper/common/loadingIndicator.dart';
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
    return Scaffold(
      key: _scaffoldKey,
      drawer: SidebarMenu(),
      body: CustomScrollView(
        slivers: [
          AppBarWidget(text: "Komsum"),
          BlocBuilder<TagFilterBloc, TagFilterState>(
              builder: (context, tagState) {
            return BlocBuilder<GeographyFilterBloc, GeographyFilterState>(
                builder: (context, geographyState) {
              if (geographyState.geographyFilterList.length == 0 &&
                  tagState.tags.length == 0) {
                return SliverToBoxAdapter(child: Container());
              } else {
                return SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    minHeight: 50,
                    maxHeight: 60,
                    child: FittedBox(
                      child: Column(
                        children: [
                          TagFilterList(),
                          GeographyFilterList(),
                        ],
                      ),
                    ),
                  ),
                );
              }
            });
          }),
          SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverToBoxAdapter(
            child:
            BlocProvider<PostListBloc>(
              create: (BuildContext context) => PostListBloc(
                tagFilterBloc: BlocProvider.of<TagFilterBloc>(context),
                geographyFilterBloc: BlocProvider.of<GeographyFilterBloc>(context),
              )..add(PostListLoad()),
              child: PostList(),
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.createPostPage);
        },
        child: const Icon(Icons.send),
        backgroundColor: Colors.green,
      ),
    );
  }
}
