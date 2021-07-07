import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/helper/common/loadingIndicator.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/tag/bloc/list/tagListBarrel.dart';
import 'package:komsum/tag/widget/tagListItemWidget.dart';


class TagListWidget extends StatelessWidget {

  const TagListWidget({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagListBloc, TagListState>(
    builder: (context, state) {
      if(state is TagListLoadInProgress) {
        return LoadingIndicator(key: TagKeys.loadingTagList);
      } else if (state is TagListLoadedSuccess) {
        final tags = state.tags;
        return CustomScrollView(slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 4,
                mainAxisSpacing: 5,
                crossAxisSpacing: 1
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return TagListItem(tags[index]);
              },
              childCount: tags.length,
            ),
          ),
        ]);
      }else {
        return Container(key: TagKeys.emptyTagListContainer);
      }
    });
  }

}