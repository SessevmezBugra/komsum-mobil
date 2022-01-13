import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/helper/common/appbar.dart';
import 'package:komsum/helper/common/loadingIndicator.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/user/bloc/auth/authenticationBloc.dart';
import 'package:komsum/user/bloc/post/userPostBarrel.dart';
import 'package:komsum/user/bloc/user/userBarrel.dart';
import 'package:komsum/user/widget/personSidebarMenu.dart';
import 'package:komsum/user/widget/userPostList.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  ProfilePage(this.username, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}


class _ProfilePageState extends State<ProfilePage> {
  final _scrollController = ScrollController();
  UserPostListBloc _userPostListBloc;
  final host = KomsumConst.API_HOST;
  final protocol = KomsumConst.PROTOCOL;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _userPostListBloc = context.read<UserPostListBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // print('_onScroll');

    if (_isBottom) {
      if (!(_userPostListBloc.state as UserPostListLoadedSuccess).last) {
        print('PostListLoad');
        _userPostListBloc.add(LoadUserPostList(widget.username));
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
        BlocProvider
            .of<AuthenticationBloc>(context)
            .state
            .token
            .accessToken;
    return Scaffold(
      // drawer: PersonSidebarMenu(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadedSuccess) {
                  return Text(state.user.firstName + ' ' + state.user.lastName);
                }
                return Text('');
              },),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            leading: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadedSuccess) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          RouteNames.picturePage +
                              "/" +
                              (state.user.attributes == null || state.user.attributes.first.value == null ? '' : state.user.attributes.first.value));
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
                              value: loadingProgress.expectedTotalBytes !=
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
                      Navigator.pushNamed(
                          context,
                          RouteNames.picturePage +
                              "/");
                    },
                    child: Icon(Icons.photo),
                  );
                }
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverToBoxAdapter(
            child: UserPostList(),
          )
        ],
      ),
    );
  }
}
