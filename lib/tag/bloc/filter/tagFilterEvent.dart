import 'package:equatable/equatable.dart';
import 'package:komsum/tag/model/tag.dart';

abstract class TagFilterEvent extends Equatable {
  const TagFilterEvent();

  @override
  List<Object> get props => [];
}

class TagAddedToFilterList extends TagFilterEvent {
  final Tag tag;

  const TagAddedToFilterList(this.tag);
  @override
  List<Object> get props => [tag];
}

class TagDeletedFromFilterList extends TagFilterEvent {
  final Tag tag;

  const TagDeletedFromFilterList(this.tag);

  @override
  List<Object> get props => [tag];
}