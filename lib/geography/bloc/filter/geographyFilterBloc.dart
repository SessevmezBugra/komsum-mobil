import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:komsum/geography/bloc/filter/geographyFilterEvent.dart';
import 'package:komsum/geography/bloc/filter/geographyFilterState.dart';
import 'package:komsum/geography/model/geography.dart';
import 'package:komsum/helper/constants.dart';

class GeographyFilterBloc
    extends Bloc<GeographyFilterEvent, GeographyFilterState> {

  GeographyFilterBloc()
      : super(GeographyFilterState([]));

  @override
  Stream<GeographyFilterState> mapEventToState(
      GeographyFilterEvent event) async* {

    if (event is GeographyFilterAdded) {
      yield* _mapGeographyFilterAddedToState(event.geography);
    } else if (event is GeographyFilterRemoved) {
      yield* _mapGeographyFilterRemovedToState(event.geography);
    }
  }

  Stream<GeographyFilterState> _mapGeographyFilterAddedToState(
      Geography geography) async* {
    List<Geography> geographies = List.of(state.geographyFilterList);
    geographies.add(geography);

    yield GeographyFilterState(geographies);
  }

  Stream<GeographyFilterState> _mapGeographyFilterRemovedToState(
      Geography geography) async* {
    List<Geography> geographies = List.of(state.geographyFilterList);
    if(geography.type == GeographyConst.city) {
      for(Geography geo in state.geographyFilterList) {
        geographies.remove(geo);
      }
    }else if(geography.type == GeographyConst.district) {
      for(Geography geo in state.geographyFilterList) {
        if(geo.type != GeographyConst.city) {
          geographies.remove(geo);
        }
      }
    }else if(geography.type == GeographyConst.neighborhood) {
      for(Geography geo in state.geographyFilterList) {
        if(geo.type == GeographyConst.neighborhood || geo.type == GeographyConst.street) {
          geographies.remove(geo);
        }
      }
    }else if(geography.type == GeographyConst.street) {
      geographies.remove(geography);
    }
    yield GeographyFilterState(geographies);
  }
}
