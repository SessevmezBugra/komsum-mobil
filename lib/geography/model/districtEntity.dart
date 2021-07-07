// To parse this JSON data, do
//
//     final districtEntity = districtEntityFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DistrictEntity> districtEntityFromJson(String str) => List<DistrictEntity>.from(json.decode(str).map((x) => DistrictEntity.fromJson(x)));

String districtEntityToJson(List<DistrictEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistrictEntity {
  DistrictEntity({
    @required this.id,
    @required this.name,
    @required this.cityName,
  });

  int id;
  String name;
  String cityName;

  DistrictEntity copyWith({
    int id,
    String name,
    String cityName,
  }) =>
      DistrictEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        cityName: cityName ?? this.cityName,
      );

  factory DistrictEntity.fromJson(Map<String, dynamic> json) => DistrictEntity(
    id: json["id"],
    name: json["name"],
    cityName: json["cityName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cityName": cityName,
  };
}

