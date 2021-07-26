import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';
import 'package:komsum/geography/model/geography.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/bloc/list/postListBarrel.dart';
import 'package:http/http.dart' as http;
import 'package:komsum/post/model/postPage.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/model/tag.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final http.Client httpClient = http.Client();
  final GeographyFilterBloc geographyFilterBloc;
  final TagFilterBloc tagFilterBloc;

  StreamSubscription geographyFilterSubscription;
  StreamSubscription tagFilterSubscription;

  PostListBloc(
      {@required this.geographyFilterBloc, @required this.tagFilterBloc})
      : super(PostListLoadInProgress()) {
    geographyFilterSubscription = geographyFilterBloc.stream.listen((state) {
      add(PostListLoad());
    });
    tagFilterSubscription = tagFilterBloc.stream.listen((state) {
      add(PostListLoad());
    });
  }

  @override
  Stream<PostListState> mapEventToState(PostListEvent event) async* {
    if (event is PostListLoad) {
      yield* _mapPostListLoadToState();
    }
  }

  Stream<PostListState> _mapPostListLoadToState() async* {
    try {
      print("1");
      yield PostListLoadInProgress();
      Geography country = geographyFilterBloc.state.geographyFilterList.firstWhere((e) => e.type == GeographyConst.country, orElse: () => Geography(218, null, null));
      Geography city = geographyFilterBloc.state.geographyFilterList.firstWhere((e) => e.type == GeographyConst.city, orElse: () => Geography(null, null, null));
      Geography district = geographyFilterBloc.state.geographyFilterList.firstWhere((e) => e.type == GeographyConst.district, orElse: () => Geography(null, null, null));
      Geography neighborhood = geographyFilterBloc.state.geographyFilterList.firstWhere((e) => e.type == GeographyConst.neighborhood, orElse: () => Geography(null, null, null));
      Geography street = geographyFilterBloc.state.geographyFilterList.firstWhere((e) => e.type == GeographyConst.street, orElse: () => Geography(null, null, null));
      List<Tag> tags = tagFilterBloc.state.tags;
      print("2");
      final postPage = await _fetchPosts(
        countryId: country.id,
        cityId: city.id,
        districtId: district.id,
        neighborhoodId: neighborhood.id,
        streetId: street.id,
        tagIds: tags.map((e) => e.id).toList(),
      );
      print("3");
      yield PostListLoadedSuccess(postPage);
      print("4");
    } catch (_) {
      print("5");
      print(_);
      yield PostListLoadFailure();
    }
  }

  Future<PostPage> _fetchPosts({
    int countryId,
    int cityId,
    int districtId,
    int neighborhoodId,
    int streetId,
    List<String> tagIds,
    int pageNumber
  }) async {
    var host = KomsumConst.host;
    final queryParameters = {
      'countryId': countryId != null ? countryId.toString() : '',
      'cityId': cityId != null ? cityId.toString() : '',
      'districtId': districtId != null ? districtId.toString() : '',
      'neighborhoodId': neighborhoodId != null ? neighborhoodId.toString() : '',
      'streetId': streetId != null ? streetId.toString() : '',
      'tagIds': tagIds,
      'pageNumber': pageNumber != null ? pageNumber.toString() : '',
    };
    print('queryParameters: ' + queryParameters.toString());
    final response = await httpClient.get(
      Uri.http('$host:8093', '/feed/post', queryParameters),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return postPageFromJson(response.body);
    }
    throw Exception('error fetching post list');
  }

  @override
  Future<void> close() {
    geographyFilterSubscription.cancel();
    tagFilterSubscription.cancel();
    return super.close();
  }
}
