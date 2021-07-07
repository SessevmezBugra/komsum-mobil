import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/bloc/list/tagListBarrel.dart';
import 'package:komsum/tag/model/tag.dart';

class TagFilterListItem extends StatelessWidget {
  final Tag tag;

  const TagFilterListItem(this.tag, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputChip(
      avatar: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.tag,
          color: Colors.redAccent,
        ),
      ),
      label: FittedBox(
        child: Text(
          tag.trDesc,
        ),
      ),
      onDeleted: () {
        BlocProvider.of<TagFilterBloc>(context)
            .add(TagDeletedFromFilterList(tag));
        BlocProvider.of<TagListBloc>(context)
            .add(TagAddedToList(tag));
      },
    );
  }
}
