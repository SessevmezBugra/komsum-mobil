import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/model/postPage.dart';
import 'package:komsum/user/bloc/auth/authenticationBarrel.dart';
import 'package:komsum/user/bloc/post/userPostBarrel.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class UserPostListBloc extends Bloc<UserPostListEvent, UserPostListState> {
  final http.Client httpClient = http.Client();
  final AuthenticationBloc authBloc;
  int pageNumber = 0;

  UserPostListBloc({
    @required this.authBloc,
  }) : super(UserPostListInProgress());

  @override
  Stream<Transition<UserPostListEvent, UserPostListState>> transformEvents(
    Stream<UserPostListEvent> events,
    TransitionFunction<UserPostListEvent, UserPostListState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 1000)),
      transitionFn,
    );
  }

  @override
  Stream<UserPostListState> mapEventToState(UserPostListEvent event) async* {
    if (event is LoadUserPostList) {
      yield* _mapLoadUserPostListToState(event.username, state);
    } else if (event is LoadInitialUserPostList) {
      yield* _mapLoadInitialUserPostListToState(event.username);
    }
  }

  Stream<UserPostListState> _mapLoadUserPostListToState(
      String username, UserPostListLoadedSuccess state) async* {
    try {

      if (state.last) {

        yield state;
        return;
      }

      final postPage =
          await _fetchPosts(username: username, pageNumber: pageNumber);
      if (pageNumber != 0) {

        yield state.copyWith(
            posts: List.of(state.posts)..addAll(postPage.content),
            last: postPage.last);
      } else {
        yield UserPostListLoadedSuccess(
            posts: postPage.content, last: postPage.last);
      }
      if (!postPage.last) {
        pageNumber++;
      }

    } catch (_) {
      print("5");
      print(_);
      yield UserPostListLoadFailure();
    }
  }

  Stream<UserPostListState> _mapLoadInitialUserPostListToState(
      String username) async* {
    try {
      pageNumber = 0;
      yield UserPostListInProgress();
      final postPage = await _fetchPosts(
        username: username,
        pageNumber: 0,
      );
      yield UserPostListLoadedSuccess(
          posts: postPage.content, last: postPage.last);
      if (!postPage.last) {
        pageNumber++;
      }
    } catch (_) {
      print(_);
      yield UserPostListLoadFailure();
    }
  }

  Future<PostPage> _fetchPosts({String username, int pageNumber}) async {
    final queryParameters = {
      'username': username != null ? username : '',
      'pageNumber': pageNumber != null ? pageNumber.toString() : '',
    };
    print('queryParameters: ' + queryParameters.toString());
    var token = authBloc.state.token.accessToken;
    Uri uri = KomsumConst.PROTOCOL == 'http'
        ? Uri.http(KomsumConst.API_HOST, '/feed/post', queryParameters)
        : Uri.https(KomsumConst.API_HOST, '/feed/post', queryParameters);
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
      return postPageFromJson(utf8.decode(response.bodyBytes));
    }
    throw Exception('error fetching post list');
  }
}
