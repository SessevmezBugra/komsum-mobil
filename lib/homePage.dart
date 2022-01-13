import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/bloc/header/headerBarrel.dart';
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';
import 'package:komsum/geography/widget/geographyFilterListWidget.dart';
import 'package:komsum/helper/common/appbar.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/bloc/list/postListBarrel.dart';
import 'package:komsum/post/model/post.dart';
import 'package:komsum/post/widget/postListWidget.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/widget/tagFilterListWidget.dart';
import 'package:komsum/user/bloc/auth/authenticationBarrel.dart';
import 'package:komsum/user/bloc/user/userBarrel.dart';

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
  HeaderBloc _headerBloc;
  final host = KomsumConst.API_HOST;
  final protocol = KomsumConst.PROTOCOL;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _postListBloc = context.read<PostListBloc>();
    _headerBloc = context.read<HeaderBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _headerBloc.add(HeaderNotPinned());
    } else {
      _headerBloc.add(HeaderPinned());
    }
    if (_isBottom) {
      if (!(_postListBloc.state as PostListLoadedSuccess).last) {
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
    final token =
        BlocProvider.of<AuthenticationBloc>(context).state.token.accessToken;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SidebarMenu(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: Text(
              'Komsum',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            // pinned: true,
            snap: true,
            floating: true,
            leading: InkWell(
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
              child: Icon(
                Icons.filter_alt_outlined,
              ),
            ),
            actions: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoadedSuccess) {
                    return InkWell(
                      onTap: () {
                        print('InkWell');
                        Navigator.pushNamed(
                          context,
                          RouteNames.profilePage + "/" + state.user.username,
                        );
                      },
                      child: ClipOval(
                        child: state.user.attributes == null || state.user.attributes.first.value == null
                            ? Container(margin: EdgeInsets.only(right: 20,),child: Icon(Icons.person))
                            : Image.network(
                          '$protocol://$host/file/' +
                              state.user.attributes.first.value,
                          headers: {
                            'Authorization': 'Bearer $token',
                          },
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context,
                              Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                                value: loadingProgress
                                    .expectedTotalBytes !=
                                    null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is UserLoadInProgress) {
                    return LoadingIndicator(color: Colors.amber);
                  } else {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.profilePage);
                      },
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          BlocBuilder<TagFilterBloc, TagFilterState>(
              builder: (context, tagState) {
                return BlocBuilder<GeographyFilterBloc, GeographyFilterState>(
                    builder: (context, geographyState) {
                      if (geographyState.geographyFilterList.length == 0 &&
                          tagState.tags.length == 0) {
                        return SliverToBoxAdapter(child: Container());
                      } else {
                        return BlocBuilder<HeaderBloc, HeaderState>(
                            builder: (context, headerState) {
                              return SliverPersistentHeader(
                                pinned: headerState.isPinned,
                                // floating: true,
                                delegate: SliverAppBarDelegate(
                                  minHeight: 50,
                                  maxHeight: 60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey
                                    ),
                                    child: FittedBox(
                                      child: Column(
                                        children: [
                                          TagFilterList(),
                                          GeographyFilterList(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    });
              }),
          SliverToBoxAdapter(
            child: Divider(),
          ),
          PostList(),
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
