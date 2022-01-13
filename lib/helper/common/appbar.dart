import 'package:flutter/material.dart';
import 'package:komsum/geography/widget/geographyFilterListWidget.dart';
import 'package:komsum/helper/common/filterbar.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/tag/widget/tagFilterListWidget.dart';

class AppBarWidget extends StatelessWidget {
  // 1
  final String text;
  final bool centerTitle;
  final List<Widget> actions;
  final Widget leading;
  final bool pinned;

  const AppBarWidget({
    Key key,
    @required this.text,
    this.centerTitle = false,
    this.actions,
    this.leading,
    this.pinned = true
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2
    return SliverAppBar(
      leading: leading,
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),

      centerTitle: centerTitle,
      expandedHeight: 50,
      pinned: pinned,
      elevation: 0,
      actions: actions,
    );
  }
}
