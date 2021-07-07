import 'package:equatable/equatable.dart';

class Post extends Equatable{
  const Post({
    this.streetId,
    this.tagId,
    this.createdAt,
    this.postId,
  });

  final int streetId;
  final int tagId;
  final DateTime createdAt;
  final String postId;

  Post copyWith({
    int streetId,
    int tagId,
    DateTime createdAt,
    String postId,
  }) =>
      Post(
        streetId: streetId ?? this.streetId,
        tagId: tagId ?? this.tagId,
        createdAt: createdAt ?? this.createdAt,
        postId: postId ?? this.postId,
      );

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    streetId: json["streetId"],
    tagId: json["tagId"],
    createdAt: DateTime.parse(json["createdAt"]),
    postId: json["postId"],
  );

  Map<String, dynamic> toJson() => {
    "streetId": streetId,
    "tagId": tagId,
    "createdAt": createdAt.toIso8601String(),
    "postId": postId,
  };

  @override
  List<Object> get props => [streetId, tagId, createdAt, postId];
}