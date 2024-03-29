import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/helper/common/loadingIndicator.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/bloc/list/postListBarrel.dart';
import 'package:komsum/post/model/post.dart';
import 'package:komsum/post/widget/postListItemWidget.dart';
import 'package:komsum/user/bloc/auth/authenticationBarrel.dart';

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListBloc, PostListState>(
      builder: (context, state) {
        if (state is PostListLoadedSuccess) {
          List<Post> posts = state.posts;
          if (posts.isEmpty) {
            return SliverToBoxAdapter(
                child: const Center(child: Text('Henuz bir haber yok')));
          }
          // return SliverList(
          //   delegate: SliverChildListDelegate.fixed(
          //     List.generate(
          //       state.last ? posts.length : posts.length + 1,
          //       (index) => index >= state.posts.length
          //           ? CircularProgressIndicator()
          //           : PostListItem(posts[index]),
          //     ),
          //
          //   ),
          // );
          return SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: List.generate(
                  state.last ? posts.length : posts.length + 1,
                  (index) => index >= state.posts.length ? CircularProgressIndicator() : PostListItem(posts[index]),
                ),
              ),
            ),
          );
        } else if (state is PostListLoadInProgress) {
          return SliverToBoxAdapter(
            child: LoadingIndicator(
              key: PostKeys.loadingPostList,
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: LoadingIndicator(
              key: PostKeys.loadingPostList,
            ),
          );
        }
      },
    );
  }
}
