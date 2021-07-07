import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';

import 'geographyFilterListItemWidget.dart';

class GeographyFilterList extends StatefulWidget {

  GeographyFilterList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GeographyFilterState();
  }
}

class _GeographyFilterState extends State<GeographyFilterList> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeographyFilterBloc, GeographyFilterState>(
      builder: (context, state) {
        final geographyFilterList = state.geographyFilterList;
        return Wrap(
          children: List.generate(
            geographyFilterList.length,
                (index) => GeographyFilterListItem(geographyFilterList[index]),
          ),
          spacing: 3,
        );
      },
    );
  }
}
