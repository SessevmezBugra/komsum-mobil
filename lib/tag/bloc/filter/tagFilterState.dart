import 'package:equatable/equatable.dart';
import 'package:komsum/tag/model/tag.dart';

class TagFilterState extends Equatable {
  final List<Tag> tags;

  const TagFilterState([ this.tags = const [] ]);

  TagFilterState copyWith(List<Tag> tags) {
    return TagFilterState(tags ?? this.tags);
  }

  @override
  List<Object> get props => [tags];
}