import 'package:equatable/equatable.dart';
import 'package:komsum/tag/model/tag.dart';

abstract class TagListEvent extends Equatable {
  const TagListEvent();

  @override
  List<Object> get props => [];
}

class TagListLoad extends TagListEvent {}

class TagAddedToList extends TagListEvent {
  final Tag tag;

  const TagAddedToList(this.tag);
  @override
  List<Object> get props => [tag];
}

class TagDeletedFromList extends TagListEvent {
  final Tag tag;

  const TagDeletedFromList(this.tag);

  @override
  List<Object> get props => [tag];
}