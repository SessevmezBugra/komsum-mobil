import 'package:equatable/equatable.dart';
import 'package:komsum/post/model/postPage.dart';

abstract class PostListState extends Equatable {
  const PostListState();
  List<Object> get props => [];
}

class PostListLoadInProgress extends PostListState {}

class PostListLoadedSuccess extends PostListState {
  final PostPage postPage;

  const PostListLoadedSuccess([this.postPage]);

  @override
  List<Object> get props => [postPage];

}

class PostListLoadFailure extends PostListState {}