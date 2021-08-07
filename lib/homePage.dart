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
import 'package:komsum/user/bloc/authenticationBarrel.dart';

import 'helper/common/loadingIndicator.dart';
import 'helper/common/sidebar.dart';
import 'helper/common/subheader.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  PostListBloc _postListBloc;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _postListBloc = context.read<PostListBloc>();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // print('_onScroll');

    if (_isBottom){
      if(!(_postListBloc.state as PostListLoadedSuccess).last) {
        print('PostListLoad');
        _postListBloc.add(PostListLoad());
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SidebarMenu(),
      body: CustomScrollView(
        controller: _scrollController,
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
            child: PostList(),
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
