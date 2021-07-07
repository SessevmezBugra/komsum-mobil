
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/model/tag.dart';

class TagFilterBloc extends Bloc<TagFilterEvent, TagFilterState> {

  TagFilterBloc() : super(TagFilterListLoadedSuccess([]));

  @override
  Stream<TagFilterState> mapEventToState(TagFilterEvent event) async*{
    if(event is TagAddedToFilterList) {
      yield* _mapTagAddedToState(event.tag);
    }else if(event is TagDeletedFromFilterList) {
      yield* _mapTagDeletedToState(event.tag);
    }
  }

  Stream<TagFilterState> _mapTagAddedToState(Tag tag) async*{
    if(state is TagFilterListLoadedSuccess) {
      // yield TagFilterListLoadInProgress();
      List<Tag> tags =  List.from((state as TagFilterListLoadedSuccess).tags)
      ..add(tag);
      yield TagFilterListLoadedSuccess(tags);
    }

  }

  Stream<TagFilterState> _mapTagDeletedToState(Tag tag) async*{
    if(state is TagFilterListLoadedSuccess) {
      // yield TagFilterListLoadInProgress();
      List<Tag> tags =  List.from((state as TagFilterListLoadedSuccess).tags)
        ..remove(tag);
      yield TagFilterListLoadedSuccess(tags);
    }
  }

}