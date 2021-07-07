// To parse this JSON data, do
//
//     final neighborhoodEntity = neighborhoodEntityFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<NeighborhoodEntity> neighborhoodEntityFromJson(String str) => List<NeighborhoodEntity>.from(json.decode(str).map((x) => NeighborhoodEntity.fromJson(x)));

String neighborhoodEntityToJson(List<NeighborhoodEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NeighborhoodEntity {
  NeighborhoodEntity({
    @required this.id,
    @required this.name,
    @required this.districtName,
    @required this.cityId,
    @required this.cityName,
  });

  int id;
  String name;
  String districtName;
  int cityId;
  String cityName;

  NeighborhoodEntity copyWith({
    int id,
    String name,
    String districtName,
    int cityId,
    String cityName,
  }) =>
      NeighborhoodEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        districtName: districtName ?? this.districtName,
        cityId: cityId ?? this.cityId,
        cityName: cityName ?? this.cityName,
      );

  factory NeighborhoodEntity.fromJson(Map<String, dynamic> json) => NeighborhoodEntity(
    id: json["id"],
    name: json["name"],
    districtName: json["districtName"],
    cityId: json["cityId"],
    cityName: json["cityName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "districtName": districtName,
    "cityId": cityId,
    "cityName": cityName,
  };
}

