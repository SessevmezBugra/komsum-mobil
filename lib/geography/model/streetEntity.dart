// To parse this JSON data, do
//
//     final streetEntity = streetEntityFromJson(jsonString);

import 'dart:convert';

List<StreetEntity> streetEntityFromJson(String str) => List<StreetEntity>.from(json.decode(str).map((x) => StreetEntity.fromJson(x)));

String streetEntityToJson(List<StreetEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StreetEntity {
  StreetEntity({
    this.id,
    this.name,
    this.neighborhoodName,
    this.districtId,
    this.districtName,
    this.cityId,
    this.cityName,
  });

  int id;
  String name;
  String neighborhoodName;
  int districtId;
  String districtName;
  int cityId;
  String cityName;

  StreetEntity copyWith({
    int id,
    String name,
    String neighborhoodName,
    int districtId,
    String districtName,
    int cityId,
    String cityName,
  }) =>
      StreetEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        neighborhoodName: neighborhoodName ?? this.neighborhoodName,
        districtId: districtId ?? this.districtId,
        districtName: districtName ?? this.districtName,
        cityId: cityId ?? this.cityId,
        cityName: cityName ?? this.cityName,
      );

  factory StreetEntity.fromJson(Map<String, dynamic> json) => StreetEntity(
    id: json["id"],
    name: json["name"],
    neighborhoodName: json["neighborhoodName"],
    districtId: json["districtId"],
    districtName: json["districtName"],
    cityId: json["cityId"],
    cityName: json["cityName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "neighborhoodName": neighborhoodName,
    "districtId": districtId,
    "districtName": districtName,
    "cityId": cityId,
    "cityName": cityName,
  };
}
