import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';
import 'package:komsum/geography/bloc/list/geographyListBarrel.dart';
import 'package:komsum/geography/model/geography.dart';
import 'package:komsum/helper/constants.dart';

class GeographyFilterListItem extends StatelessWidget {
  final Geography geography;

  const GeographyFilterListItem(this.geography, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputChip(
      avatar: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.location_on,
          color: Colors.green,
        ),
      ),
      label: FittedBox(
        child: Text(
          geography.name,
        ),
      ),
      onDeleted: () {
        final filterList = List.of(BlocProvider.of<GeographyFilterBloc>(context)
            .state
            .geographyFilterList);
        BlocProvider.of<GeographyFilterBloc>(context)
            .add(GeographyFilterRemoved(geography));
        if (geography.type == GeographyConst.city) {
          BlocProvider.of<GeographyListBloc>(context)
              .add(GeographyCityListLoad());
        } else if (geography.type == GeographyConst.district) {
          final parent = filterList
              .firstWhere((element) => element.type == GeographyConst.city);
          BlocProvider.of<GeographyListBloc>(context)
              .add(GeographyDistrictListLoad(parent));
        } else if (geography.type == GeographyConst.neighborhood) {
          final parent = filterList
              .firstWhere((element) => element.type == GeographyConst.district);
          BlocProvider.of<GeographyListBloc>(context)
              .add(GeographyNeighborhoodListLoad(parent));
        } else if (geography.type == GeographyConst.street) {
          final parent = filterList.firstWhere(
              (element) => element.type == GeographyConst.neighborhood);
          BlocProvider.of<GeographyListBloc>(context)
              .add(GeographyStreetListLoad(parent));
        }
      },
    );
  }
}
