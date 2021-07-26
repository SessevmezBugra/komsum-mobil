import 'package:equatable/equatable.dart';

abstract class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object> get props => [];
}

class PostCreatedInInitialize extends CreatePostState {}

class PostCreatedInProgress extends CreatePostState {}

class PostCreatedSuccess extends CreatePostState {}

class PostCreatedFailure extends CreatePostState {}
