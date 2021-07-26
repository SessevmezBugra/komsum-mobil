import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/post/model/post.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/model/tag.dart';

class PostTagList extends StatelessWidget {

  final Post post;

  PostTagList(this.post);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagFilterBloc, TagFilterState>(
      builder: (context, state) {
          final tagFilterList = state.tags;
          List<Tag> tag = [];
          // tagFilterList.firstWhere((t) => post.)
          return Wrap(
            // children: List.generate(
            //   tagFilterList.length,
            //       (index) => TagFilterListItem(tagFilterList[index]),
            // ),
            spacing: 3,
          );
      },
    );
  }

}