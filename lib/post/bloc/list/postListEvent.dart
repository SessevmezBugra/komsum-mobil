import 'package:equatable/equatable.dart';

abstract class PostListEvent extends Equatable {
  const PostListEvent();

  @override
  List<Object> get props => [];
}

class PostListLoad extends PostListEvent {

  const PostListLoad();

  @override
  List<Object> get props => [];
}

class PostListInitialLoad extends PostListEvent {

  const PostListInitialLoad();

  @override
  List<Object> get props => [];
}