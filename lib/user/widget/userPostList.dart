import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/helper/common/loadingIndicator.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/model/post.dart';
import 'package:komsum/post/widget/postListItemWidget.dart';
import 'package:komsum/user/bloc/post/userPostBarrel.dart';

class UserPostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPostListBloc, UserPostListState>(
      builder: (context, state) {
        if (state is UserPostListLoadedSuccess) {
          List<Post> posts = state.posts;
          if (posts.isEmpty) {
            return const Center(child: Text('Henuz bir haber yok'));
          }
          return Container(
            child: Column(
              children: List.generate(
                state.last ? posts.length : posts.length + 1,
                (index) => index >= state.posts.length
                    ? CircularProgressIndicator()
                    : PostListItem(posts[index]),
              ),
            ),
          );
        } else if (state is UserPostListInProgress) {
          return LoadingIndicator();
        } else {
          return LoadingIndicator();
        }
      },
    );
  }
}
