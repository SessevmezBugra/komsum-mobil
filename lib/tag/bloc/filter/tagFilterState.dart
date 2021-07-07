import 'package:equatable/equatable.dart';
import 'package:komsum/tag/model/tag.dart';

abstract class TagFilterState extends Equatable {
  const TagFilterState();
  @override
  List<Object> get props => [];
}

class TagFilterListLoadInProgress extends TagFilterState {}

class TagFilterListLoadedSuccess extends TagFilterState {

  final List<Tag> tags;

  const TagFilterListLoadedSuccess([ this.tags = const [] ]);

  TagFilterState copyWith(List<Tag> tags) {
    return TagFilterListLoadedSuccess(tags ?? this.tags);
  }

  @override
  List<Object> get props => [tags];
}