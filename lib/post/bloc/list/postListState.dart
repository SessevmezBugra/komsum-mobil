import 'package:equatable/equatable.dart';
import 'package:komsum/post/model/post.dart';

enum PostStatus { initial, success, failure }

class PostListState extends Equatable {
  const PostListState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
    this.page,
    this.cityId,
    this.districtId,
    this.neighborhoodId,
    this.streetId,
    this.tagIds
  });

  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;
  final int page;
  final int cityId;
  final int districtId;
  final int neighborhoodId;
  final int streetId;
  final List<int> tagIds;

  PostListState copyWith({
    PostStatus status,
    List<Post> posts,
    bool hasReachedMax,
    int page,
    int cityId,
    int districtId,
    int neighborhoodId,
    int streetId,
    List<int> tagIds
  }) {
    return PostListState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      cityId: cityId ?? this.cityId,
      districtId: districtId ?? this.districtId,
      neighborhoodId: neighborhoodId ?? this.neighborhoodId,
      streetId: streetId ?? this.streetId,
      tagIds: tagIds ?? this.tagIds
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax, page, cityId, districtId, neighborhoodId, streetId, tagIds];
}