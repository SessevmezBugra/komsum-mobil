
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:komsum/post/model/post.dart';

PostPage postPageFromJson(String str) => PostPage.fromJson(json.decode(str));

String postPageToJson(PostPage data) => json.encode(data.toJson());

class PostPage extends Equatable{
  const PostPage({
    this.pageState,
    this.content,
    this.last,
  });

  final dynamic pageState;
  final List<Post> content;
  final bool last;

  PostPage copyWith({
    dynamic pageState,
    List<Post> content,
    bool last,
  }) =>
      PostPage(
        pageState: pageState ?? this.pageState,
        content: content ?? this.content,
        last: last ?? this.last,
      );

  factory PostPage.fromJson(Map<String, dynamic> json) => PostPage(
    pageState: json["pageState"],
    content: List<Post>.from(json["content"].map((x) => Post.fromJson(x))),
    last: json["last"],
  );

  Map<String, dynamic> toJson() => {
    "pageState": pageState,
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "last": last,
  };

  @override
  List<Object> get props => [pageState, content, last];
}
