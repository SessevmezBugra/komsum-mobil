// To parse this JSON data, do
//
//     final tag = tagFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Tag> tagFromJson(String str) => List<Tag>.from(json.decode(str).map((x) => Tag.fromJson(x)));

String tagToJson(List<Tag> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tag extends Equatable{
  Tag({
    this.id,
    this.key,
    this.trDesc,
    this.enDesc,
  });

  String id;
  String key;
  String trDesc;
  String enDesc;

  Tag copyWith({
    String id,
    String key,
    String trDesc,
    String enDesc,
  }) =>
      Tag(
        id: id ?? this.id,
        key: key ?? this.key,
        trDesc: trDesc ?? this.trDesc,
        enDesc: enDesc ?? this.enDesc,
      );

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    key: json["key"],
    trDesc: json["trDesc"],
    enDesc: json["enDesc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "trDesc": trDesc,
    "enDesc": enDesc,
  };

  @override
  List<Object> get props => [id, key, trDesc, enDesc];
}
