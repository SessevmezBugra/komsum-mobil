import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:komsum/helper/constants.dart';
import 'package:komsum/tag/bloc/list/tagListBarrel.dart';
import 'package:komsum/tag/model/tag.dart';
import 'package:komsum/user/bloc/authenticationBarrel.dart';

class TagListBloc extends Bloc<TagListEvent, TagListState> {
  final AuthenticationBloc authBloc;
  final http.Client httpClient = http.Client();

  TagListBloc({@required this.authBloc}) : super(TagListLoadInProgress());

  @override
  Stream<TagListState> mapEventToState(TagListEvent event) async* {
    if (event is TagListLoad) {
      yield* _mapTagListLoadToState();
    } else if (event is TagAddedToList) {
      yield* _mapTagAddedToState(event.tag);
    } else if (event is TagDeletedFromList) {
      yield* _mapTagDeletedToState(event.tag);
    }
  }

  Stream<TagListState> _mapTagListLoadToState() async* {
    try {
      final tags = await _fetchTags();
      yield TagListLoadedSuccess(tags);
    } catch (_) {
      yield TagListLoadFailure();
    }
  }

  Stream<TagListState> _mapTagAddedToState(Tag tag) async* {
    if (state is TagListLoadedSuccess) {
      List<Tag> tags = List.from((state as TagListLoadedSuccess).tags);
      tags.add(tag);
      yield (state as TagListLoadedSuccess).copyWith(tags);
    }
  }

  Stream<TagListState> _mapTagDeletedToState(Tag tag) async* {
    print("TEST1");
    if (state is TagListLoadedSuccess) {
      print("TEST2");
      List<Tag> tags = List.from((state as TagListLoadedSuccess).tags);
      tags.remove(tag);
      yield (state as TagListLoadedSuccess).copyWith(tags);
    }
  }

  Future<List<Tag>> _fetchTags() async {
    var token = authBloc.state.token.accessToken;
    Uri uri = KomsumConst.PROTOCOL == 'http'
        ? Uri.http(KomsumConst.API_HOST, '/tag')
        : Uri.https(KomsumConst.API_HOST, '/tag');
    final response = await httpClient.get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return tagFromJson(utf8.decode(response.bodyBytes));
    }
    throw Exception('error fetching Tags');
  }
}
