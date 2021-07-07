import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';
import 'package:komsum/geography/bloc/list/geographyListBarrel.dart';
import 'package:komsum/geography/model/geography.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';

class GeographyListItem extends StatefulWidget {
  final Geography geography;

  const GeographyListItem(this.geography, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GeographyListState();
  }
}

class _GeographyListState extends State<GeographyListItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ActionChip(
        avatar: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.location_on,
            color: Colors.green,
            size: 20,
          ),
        ),
        label: FittedBox(
          child: Text(
            widget.geography.name,
            textAlign: TextAlign.start,
          ),
        ),
        onPressed: () {
          if (widget.geography.type == GeographyConst.city) {
            BlocProvider.of<GeographyListBloc>(context)
                .add(GeographyDistrictListLoad(widget.geography));
          } else if (widget.geography.type == GeographyConst.district) {
            BlocProvider.of<GeographyListBloc>(context)
                .add(GeographyNeighborhoodListLoad(widget.geography));
          } else if (widget.geography.type == GeographyConst.neighborhood) {
            BlocProvider.of<GeographyListBloc>(context)
                .add(GeographyStreetListLoad(widget.geography));
          } else if (widget.geography.type == GeographyConst.street) {
            BlocProvider.of<GeographyListBloc>(context)
                .add(GeographyEmptyListLoad());
          }
          BlocProvider.of<GeographyFilterBloc>(context)
              .add(GeographyFilterAdded(widget.geography));
        },
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
