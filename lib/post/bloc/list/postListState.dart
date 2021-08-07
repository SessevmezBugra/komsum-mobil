import 'package:equatable/equatable.dart';
import 'package:komsum/post/model/post.dart';
import 'package:komsum/post/model/postPage.dart';

abstract class PostListState extends Equatable {
  const PostListState();

  List<Object> get props => [];
}

class PostListLoadInProgress extends PostListState {}

class PostListLoadedSuccess extends PostListState {
  const PostListLoadedSuccess({this.posts, this.last});

  final List<Post> posts;
  final bool last;

  PostListLoadedSuccess copyWith({List<Post> posts, bool last}) {
    return PostListLoadedSuccess(posts: posts ?? this.posts, last: last ?? this.last);
  }

  @override
  List<Object> get props => [posts, last];
}

class PostListLoadFailure extends PostListState {}
