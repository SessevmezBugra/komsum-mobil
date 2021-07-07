import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/bloc/list/tagListBarrel.dart';
import 'package:komsum/tag/model/tag.dart';

class TagListItem extends StatefulWidget {
  final Tag tag;

  const TagListItem(this.tag, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TagListState();
  }
}

class _TagListState extends State<TagListItem> {
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.tag,
          color: Colors.redAccent,
          size: 20,
        ),
      ),
      label: FittedBox(
        child: Text(
          widget.tag.trDesc,
        ),
      ),
      onPressed: () {
        BlocProvider.of<TagFilterBloc>(context)
            .add(TagAddedToFilterList(widget.tag));
        BlocProvider.of<TagListBloc>(context)
            .add(TagDeletedFromList(widget.tag));
      },
      backgroundColor: Colors.grey[200],
    );
  }
}
