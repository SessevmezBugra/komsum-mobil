import 'package:flutter/material.dart';
import 'package:komsum/geography/widget/geographyFilterListWidget.dart';
import 'package:komsum/tag/widget/tagFilterListWidget.dart';

class FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          GeographyFilterList(), TagFilterList()
        ],
      ),
    );
  }
}
