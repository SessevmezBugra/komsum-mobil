import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:komsum/geography/model/cityEntity.dart';
import 'package:komsum/geography/model/districtEntity.dart';
import 'package:komsum/geography/model/geography.dart';
import 'package:komsum/geography/model/neighborhoodEntity.dart';
import 'package:komsum/geography/model/streetEntity.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/user/bloc/authenticationBarrel.dart';
import 'package:meta/meta.dart';

import 'package:komsum/geography/bloc/list/geographyListState.dart';
import 'package:komsum/geography/bloc/list/geographyListEvent.dart';

class GeographyListBloc extends Bloc<GeographyListEvent, GeographyListState> {
  final AuthenticationBloc authBloc;
  final http.Client httpClient = http.Client();

  GeographyListBloc({@required this.authBloc})
      : super(GeographyListLoadInProgress());

  @override
  Stream<GeographyListState> mapEventToState(GeographyListEvent event) async* {
    if (event is GeographyCityListLoad) {
      yield* _mapGeographyCityListLoadToState();
    } else if (event is GeographyDistrictListLoad) {
      print('g1');
      yield* _mapGeographyDistrictListLoadToState(event.geography);
    } else if (event is GeographyNeighborhoodListLoad) {
      yield* _mapGeographyNeighborhoodListLoadToState(event.geography);
    } else if (event is GeographyStreetListLoad) {
      yield* _mapGeographyStreetListLoadToState(event.geography);
    } else if (event is GeographyEmptyListLoad) {
      yield* _mapGeographyEmptyListLoadToState();
    }
  }

  Stream<GeographyListState> _mapGeographyCityListLoadToState() async* {
    try {
      final cities = await _fetchCities();
      yield GeographyListLoadedSuccess(
        cities.map(Geography.fromCityEntity).toList(),
      );
    } catch (_) {
      print(_);
      yield GeographyListLoadFailure();
    }
  }

  Stream<GeographyListState> _mapGeographyDistrictListLoadToState(
      Geography geography) async* {
    try {
      yield GeographyListLoadInProgress();
      final districts = await _fetchDistricts(geography.id);
      yield GeographyListLoadedSuccess(
        districts.map(Geography.fromDistrictEntity).toList(),
      );
    } catch (_) {
      yield GeographyListLoadFailure();
    }
  }

  Stream<GeographyListState> _mapGeographyNeighborhoodListLoadToState(
      Geography geography) async* {
    try {
      yield GeographyListLoadInProgress();
      final neighborhoods = await _fetchNeighborhoods(geography.id);
      yield GeographyListLoadedSuccess(
        neighborhoods.map(Geography.fromNeighborhoodEntity).toList(),
      );
    } catch (_) {
      yield GeographyListLoadFailure();
    }
  }

  Stream<GeographyListState> _mapGeographyStreetListLoadToState(
      Geography geography) async* {
    try {
      yield GeographyListLoadInProgress();
      final streets = await _fetchStreets(geography.id);
      yield GeographyListLoadedSuccess(
        streets.map(Geography.fromStreetEntity).toList(),
      );
    } catch (_) {
      yield GeographyListLoadFailure();
    }
  }

  Stream<GeographyListState> _mapGeographyEmptyListLoadToState() async* {
    try {
      yield GeographyListLoadInProgress();
      yield GeographyListLoadedSuccess([]);
    } catch (_) {
      yield GeographyListLoadFailure();
    }
  }

  Future<List<CityEntity>> _fetchCities() async {
    print("CITYYYYYY");
    var token = authBloc.state.token.accessToken;
    print(token);
    final response = await httpClient.get(
      Uri.https(KomsumConst.API_HOST, '/geography/city'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return cityEntityFromJson(utf8.decode(response.bodyBytes));
    }
    throw Exception('error fetching CityEntity');
  }

  Future<List<DistrictEntity>> _fetchDistricts(int cityId) async {
    var token = authBloc.state.token.accessToken;
    final response = await httpClient.get(
      Uri.https(KomsumConst.API_HOST, '/geography/district/city/$cityId'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return districtEntityFromJson(utf8.decode(response.bodyBytes));
    }
    throw Exception('error fetching DistrictEntity');
  }

  Future<List<NeighborhoodEntity>> _fetchNeighborhoods(int districtId) async {
    var token = authBloc.state.token.accessToken;
    final response = await httpClient.get(
      Uri.https(
          KomsumConst.API_HOST, '/geography/neighborhood/district/$districtId'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return neighborhoodEntityFromJson(utf8.decode(response.bodyBytes));
    }
    throw Exception('error fetching NeighborhoodEntity');
  }

  Future<List<StreetEntity>> _fetchStreets(int neighborhoodId) async {
    var token = authBloc.state.token.accessToken;
    final response = await httpClient.get(
      Uri.https(KomsumConst.API_HOST,
          '/geography/street/neighborhood/$neighborhoodId'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return streetEntityFromJson(utf8.decode(response.bodyBytes));
    }
    throw Exception('error fetching StreetEntity');
  }
}
