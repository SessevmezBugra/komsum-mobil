import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/widget/tagFilterListItemWidget.dart';

class TagFilterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagFilterBloc, TagFilterState>(
      builder: (context, state) {
        if(state.tags.length > 0) {
          final tagFilterList = state.tags;
          return Wrap(
            children: List.generate(
              tagFilterList.length,
                  (index) => TagFilterListItem(tagFilterList[index]),
            ),
            spacing: 3,
          );
        }else {
          return Container();
        }
      },
    );
  }

}