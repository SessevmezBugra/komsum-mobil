import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:komsum/tag/model/tag.dart';

List<Post> postListFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post extends Equatable{
  const Post({
    this.id,
    this.username,
    this.createdAt,
    this.updatedAt,
    this.content,
    this.countryId,
    this.countryName,
    this.cityId,
    this.cityName,
    this.districtId,
    this.districtName,
    this.neighborhoodId,
    this.neighborhoodName,
    this.streetId,
    this.streetName,
    this.tags,
    this.fileId
  });

  final String id;
  final String username;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String content;
  final int countryId;
  final String countryName;
  final int cityId;
  final String cityName;
  final int districtId;
  final String districtName;
  final int neighborhoodId;
  final String neighborhoodName;
  final int streetId;
  final String streetName;
  final List<Tag> tags;
  final String fileId;

  Post copyWith({
    String id,
    String username,
    DateTime createdAt,
    DateTime updatedAt,
    String content,
    int countryId,
    String countryName,
    int cityId,
    String cityName,
    int districtId,
    String districtName,
    int neighborhoodId,
    String neighborhoodName,
    int streetId,
    String streetName,
    List<String> tagIds,
    String fileId,
  }) =>
      Post(
        id: id ?? this.id,
        username: username ?? this.username,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        content: content ?? this.content,
        countryId: countryId ?? this.countryId,
        countryName: countryName ?? this.countryName,
        cityId: cityId ?? this.cityId,
        cityName: cityName ?? this.cityName,
        districtId: districtId ?? this.districtId,
        districtName: districtName ?? this.districtName,
        neighborhoodId: neighborhoodId ?? this.neighborhoodId,
        neighborhoodName: neighborhoodName ?? this.neighborhoodName,
        streetId: streetId ?? this.streetId,
        streetName: streetName ?? this.streetName,
        tags: tags ?? this.tags,
        fileId: fileId ?? this.fileId,
      );

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    username: json["username"],
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    content: json["content"],
    countryId: json["countryId"],
    countryName: json["countryName"],
    cityId: json["cityId"],
    cityName: json["cityName"],
    districtId: json["districtId"],
    districtName: json["districtName"],
    neighborhoodId: json["neighborhoodId"],
    neighborhoodName: json["neighborhoodName"],
    streetId: json["streetId"],
    streetName: json["streetName"],
    tags: json["tags"] != null ? List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))) : [],
    fileId: json["fileId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "createdAt": createdAt != null ? createdAt.toIso8601String() : null,
    "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : null,
    "content": content,
    "countryId": countryId,
    "countryName": countryName,
    "cityId": cityId,
    "cityName": cityName,
    "districtId": districtId,
    "districtName": districtName,
    "neighborhoodId": neighborhoodId,
    "neighborhoodName": neighborhoodName,
    "streetId": streetId,
    "streetName": streetName,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "fileId" : fileId
  };

  @override
  List<Object> get props => [
    id, username, createdAt, updatedAt,
    content, countryId, countryName, cityId,
    cityName, districtId, districtName, neighborhoodId,
    neighborhoodName, streetId, streetName, tags, fileId
  ];
}

