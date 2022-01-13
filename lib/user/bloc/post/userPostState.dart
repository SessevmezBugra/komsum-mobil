import 'package:equatable/equatable.dart';
import 'package:komsum/post/model/post.dart';

abstract class UserPostListState extends Equatable {
  const UserPostListState();

  @override
  List<Object> get props => [];
}

class UserPostListInProgress extends UserPostListState {}

class UserPostListLoadedSuccess extends UserPostListState {
  const UserPostListLoadedSuccess({this.posts, this.last});

  final List<Post> posts;
  final bool last;

  UserPostListLoadedSuccess copyWith({List<Post> posts, bool last}) {
    return UserPostListLoadedSuccess(posts: posts ?? this.posts, last: last ?? this.last);
  }

  @override
  List<Object> get props => [posts, last];
}

class UserPostListLoadFailure extends UserPostListState {}