import 'package:flutter/material.dart';
import 'package:komsum/geography/widget/geographyFilterListWidget.dart';
import 'package:komsum/helper/common/filterbar.dart';
import 'package:komsum/tag/widget/tagFilterListWidget.dart';

class AppBarWidget extends StatelessWidget {
  // 1
  final String text;
  final bool centerTitle;

  const AppBarWidget({
    Key key,
    @required this.text,
    this.centerTitle = false,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2
    return SliverAppBar(
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blueGrey,
      centerTitle: centerTitle,
      // 3
      // 4
      expandedHeight: 50,
      pinned: false,
      elevation: 0,
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(100),
      //   child: FittedBox(
      //     child: Column(
      //       children: [TagFilterList(), GeographyFilterList()],
      //     ),
      //   ),
      // ),
    );
  }
}
