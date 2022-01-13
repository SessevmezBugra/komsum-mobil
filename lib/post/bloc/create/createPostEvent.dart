import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:komsum/post/model/post.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class PostCreated extends CreatePostEvent {
  final Post post;
  final Uint8List file;

  const PostCreated(this.post, this.file);

  @override
  List<Object> get props => [this.post, this.file];
}
