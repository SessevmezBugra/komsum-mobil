import 'package:equatable/equatable.dart';
import 'package:komsum/tag/model/tag.dart';

abstract class TagListState extends Equatable {
  const TagListState();

  @override
  List<Object> get props => [];
}

class TagListLoadInProgress extends TagListState {}

class TagListLoadedSuccess extends TagListState {
  final List<Tag> tags;

  const TagListLoadedSuccess([this.tags = const []]);

  TagListLoadedSuccess copyWith(List<Tag> tags) {
    return TagListLoadedSuccess(tags ?? this.tags);
  }
  @override
  List<Object> get props => [tags];
}

class TagListLoadFailure extends TagListState {}