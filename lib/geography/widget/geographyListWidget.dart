import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/geography/bloc/list/geographyListBarrel.dart';
import 'package:komsum/geography/widget/geographyListItemWidget.dart';
import 'package:komsum/helper/common/loadingIndicator.dart';
import 'package:komsum/helper/constants.dart';

class GeographyListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeographyListBloc, GeographyListState>(
        builder: (context, state) {
      if (state is GeographyListLoadInProgress) {
        return LoadingIndicator(key: GeographyKeys.loadingGeographyList);
      } else if (state is GeographyListLoadedSuccess) {
        final geographies = state.geographies;
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
                return GeographyListItem(geographies[index]);
              },
              childCount: geographies.length,
            ),
          ),
        ]);
      } else {
        return Container(key: GeographyKeys.emptyGeographyListContainer);
      }
    });
  }
}
