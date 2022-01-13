import 'package:equatable/equatable.dart';

abstract class UserPostListEvent extends Equatable {
  const UserPostListEvent();

  @override
  List<Object> get props => [];
}

class LoadUserPostList extends UserPostListEvent {
  final String username;

  const LoadUserPostList(this.username);

  @override
  List<Object> get props => [username];
}

class LoadInitialUserPostList extends UserPostListEvent {
  final String username;

  const LoadInitialUserPostList(this.username);

  @override
  List<Object> get props => [username];
}