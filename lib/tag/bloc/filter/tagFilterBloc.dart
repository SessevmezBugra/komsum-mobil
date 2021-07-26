
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/model/tag.dart';

class TagFilterBloc extends Bloc<TagFilterEvent, TagFilterState> {

  TagFilterBloc() : super(TagFilterState([]));

  @override
  Stream<TagFilterState> mapEventToState(TagFilterEvent event) async*{
    if(event is TagAddedToFilterList) {
      yield* _mapTagAddedToState(event.tag);
    }else if(event is TagDeletedFromFilterList) {
      yield* _mapTagDeletedToState(event.tag);
    }
  }

  Stream<TagFilterState> _mapTagAddedToState(Tag tag) async*{
      List<Tag> tags =  List.from(state.tags)
      ..add(tag);
      yield TagFilterState(tags);

  }

  Stream<TagFilterState> _mapTagDeletedToState(Tag tag) async*{
      List<Tag> tags =  List.from(state.tags)
        ..remove(tag);
      yield TagFilterState(tags);
  }

}