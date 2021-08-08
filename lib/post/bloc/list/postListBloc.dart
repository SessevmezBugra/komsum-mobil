import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';
import 'package:komsum/geography/model/geography.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/bloc/list/postListBarrel.dart';
import 'package:http/http.dart' as http;
import 'package:komsum/post/model/post.dart';
import 'package:komsum/post/model/postPage.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/model/tag.dart';
import 'package:komsum/user/bloc/authenticationBarrel.dart';
import 'package:rxdart/rxdart.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final http.Client httpClient = http.Client();
  final GeographyFilterBloc geographyFilterBloc;
  final TagFilterBloc tagFilterBloc;
  final AuthenticationBloc authBloc;
  int pageNumber = 0;

  StreamSubscription geographyFilterSubscription;
  StreamSubscription tagFilterSubscription;

  PostListBloc(
      {@required this.geographyFilterBloc,
      @required this.tagFilterBloc,
      @required this.authBloc})
      : super(PostListLoadInProgress()) {
    geographyFilterSubscription = geographyFilterBloc.stream.listen((state) {
      pageNumber = 0;
      add(PostListInitialLoad());
    });
    tagFilterSubscription = tagFilterBloc.stream.listen((state) {
      pageNumber = 0;
      add(PostListInitialLoad());
    });
  }

  @override
  Stream<Transition<PostListEvent, PostListState>> transformEvents(
      Stream<PostListEvent> events,
      TransitionFunction<PostListEvent, PostListState> transitionFn,
      ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 1000)),
      transitionFn,
    );
  }

  @override
  Stream<PostListState> mapEventToState(PostListEvent event) async* {
    if (event is PostListLoad) {
      yield* _mapPostListLoadToState(state);
    } else if (event is PostListInitialLoad) {
      yield* _mapPostListInitialLoadToState();
    }
  }

  Stream<PostListState> _mapPostListLoadToState(PostListLoadedSuccess state) async* {
    try {
      print('state initial');
      print('page Number: ' + pageNumber.toString());
      if (state.last) {
        print('state control 2');
        yield state;
        return;
      }
      print("state 1");
      //
      Geography country = geographyFilterBloc.state.geographyFilterList
          .firstWhere((e) => e.type == GeographyConst.country,
              orElse: () => Geography(218, null, null));
      Geography city = geographyFilterBloc.state.geographyFilterList.firstWhere(
          (e) => e.type == GeographyConst.city,
          orElse: () => Geography(null, null, null));
      Geography district = geographyFilterBloc.state.geographyFilterList
          .firstWhere((e) => e.type == GeographyConst.district,
              orElse: () => Geography(null, null, null));
      Geography neighborhood = geographyFilterBloc.state.geographyFilterList
          .firstWhere((e) => e.type == GeographyConst.neighborhood,
              orElse: () => Geography(null, null, null));
      Geography street = geographyFilterBloc.state.geographyFilterList
          .firstWhere((e) => e.type == GeographyConst.street,
              orElse: () => Geography(null, null, null));
      List<Tag> tags = tagFilterBloc.state.tags;
      print("state 2");
      final postPage = await _fetchPosts(
          countryId: country.id,
          cityId: city.id,
          districtId: district.id,
          neighborhoodId: neighborhood.id,
          streetId: street.id,
          tagIds: tags.map((e) => e.id).toList(),
          pageNumber: pageNumber);
      print("state 3");

      if (pageNumber != 0) {
        print("PostListLoadedSuccess new State currentData lenght: " + state.posts.length.toString());
        yield state.copyWith(posts: List.of(state.posts)..addAll(postPage.content), last: postPage.last);
      } else {
        yield PostListLoadedSuccess(posts: postPage.content, last: postPage.last);
      }
      if (!postPage.last) {
        pageNumber++;
      }
      print("state 4");
    } catch (_) {
      print("5");
      print(_);
      yield PostListLoadFailure();
    }
  }

  Future<PostPage> _fetchPosts(
      {int countryId,
      int cityId,
      int districtId,
      int neighborhoodId,
      int streetId,
      List<String> tagIds,
      int pageNumber}) async {
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
    var token = authBloc.state.token.accessToken;
    Uri uri = KomsumConst.PROTOCOL == 'http' ? Uri.http(KomsumConst.API_HOST, '/feed/post', queryParameters) : Uri.https(KomsumConst.API_HOST, '/feed/post', queryParameters);
    final response = await httpClient.get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      return postPageFromJson(response.body);
    }
    throw Exception('error fetching post list');
  }

  Stream<PostListState> _mapPostListInitialLoadToState() async* {
    try {
      yield PostListLoadInProgress();
      Geography country = geographyFilterBloc.state.geographyFilterList
          .firstWhere((e) => e.type == GeographyConst.country,
              orElse: () => Geography(218, null, null));
      Geography city = geographyFilterBloc.state.geographyFilterList.firstWhere(
          (e) => e.type == GeographyConst.city,
          orElse: () => Geography(null, null, null));
      Geography district = geographyFilterBloc.state.geographyFilterList
          .firstWhere((e) => e.type == GeographyConst.district,
              orElse: () => Geography(null, null, null));
      Geography neighborhood = geographyFilterBloc.state.geographyFilterList
          .firstWhere((e) => e.type == GeographyConst.neighborhood,
              orElse: () => Geography(null, null, null));
      Geography street = geographyFilterBloc.state.geographyFilterList
          .firstWhere((e) => e.type == GeographyConst.street,
              orElse: () => Geography(null, null, null));
      List<Tag> tags = tagFilterBloc.state.tags;

      final postPage = await _fetchPosts(
          countryId: country.id,
          cityId: city.id,
          districtId: district.id,
          neighborhoodId: neighborhood.id,
          streetId: street.id,
          tagIds: tags.map((e) => e.id).toList(),
          pageNumber: 0,);
      yield PostListLoadedSuccess(posts: postPage.content, last: postPage.last);
      if (!postPage.last) {
        pageNumber++;
      }
    } catch (_) {
      print(_);
      yield PostListLoadFailure();
    }
  }

  @override
  Future<void> close() {
    geographyFilterSubscription.cancel();
    tagFilterSubscription.cancel();
    return super.close();
  }
}
