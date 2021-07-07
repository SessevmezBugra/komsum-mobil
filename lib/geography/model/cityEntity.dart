import 'package:meta/meta.dart';
import 'dart:convert';

List<CityEntity> cityEntityFromJson(String str) => List<CityEntity>.from(json.decode(str).map((x) => CityEntity.fromJson(x)));

String cityEntityToJson(List<CityEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityEntity {
  CityEntity({
    @required this.id,
    @required this.name,
  });

  int id;
  String name;

  CityEntity copyWith({
    int id,
    String name,
  }) =>
      CityEntity(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory CityEntity.fromJson(Map<String, dynamic> json) => CityEntity(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
