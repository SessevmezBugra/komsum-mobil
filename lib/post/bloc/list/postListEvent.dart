import 'package:equatable/equatable.dart';
import 'package:komsum/geography/model/geography.dart';
import 'package:komsum/tag/model/tag.dart';

abstract class PostListEvent extends Equatable {
  const PostListEvent();

  @override
  List<Object> get props => [];
}

class PostListLoad extends PostListEvent {
  final List<Tag> tags;
  final List<Geography> geographies;

  const PostListLoad([ this.tags = const[], this.geographies = const[] ]);

  @override
  List<Object> get props => [tags, geographies];
}