import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:komsum/tag/model/tag.dart';

class PostTagItem extends StatelessWidget {
  final String tagName;

  PostTagItem(this.tagName);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
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
          tagName,
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

}