import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/post/bloc/list/postListBarrel.dart';
import 'package:http/http.dart' as http;
import 'package:komsum/post/model/post.dart';
import 'package:komsum/post/model/postPage.dart';

class PostBloc extends Bloc<PostListEvent, PostListState> {
  PostBloc({@required this.httpClient}) : super(const PostListState());

  final http.Client httpClient;

  @override
  Stream<PostListState> mapEventToState(PostListEvent event) async* {
    if (event is PostListFetched) {
      yield await _mapPostFetchedToState(event);
    }
  }

  Future<PostListState> _mapPostFetchedToState(PostListFetched event) async {
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return state.copyWith(
            status: PostStatus.success,
            posts: posts.content,
            hasReachedMax: posts.last,
            page: state.page + 1
        );
      }

      if (event.cityId == state.cityId && event.districtId == state.districtId &&
          event.neighborhoodId == state.neighborhoodId &&
          event.streetId == state.streetId &&
          event.tagIds == state.tagIds) {
        if(state.hasReachedMax) {
          return state;
        }else {
          final posts = await _fetchPosts();
          return state.copyWith(
              status: PostStatus.success,
              posts: posts.content,
              hasReachedMax: posts.last,
              page: state.page + 1
          );
        }
      }

      final posts = await _fetchPosts();
      return posts.content.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: PostStatus.success,
        posts: List.of(state.posts)
          ..addAll(posts.content),
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: PostStatus.failure);
    }
  }
}

Future<PostPage> _fetchPosts({
  int page,
  int cityId,
  int districtId,
  int neighborhoodId,
  int streetId,
  List<int> tagIds
}) async {
  final response = await httpClient.get(
      Uri.http('46.101.87.81:8093', '/feed/post', {
        "pageNumber": page ?? 0,
        "cityId": cityId ?? "",
        "districtId": districtId ?? "",
        "neighborhoodId": neighborhoodId ?? "",
        "streetId": streetId ?? "",
        "tagIds": tagIds ?? []
      }),
      headers: {'Content-Type': 'application/json; charset=utf-8'});

  if (response.statusCode == 200) {
    return postPageFromJson(utf8.decode(response.bodyBytes));
  }
  throw Exception('error fetching posts');
}}
