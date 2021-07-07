import 'package:equatable/equatable.dart';
import 'package:komsum/geography/model/cityEntity.dart';
import 'package:komsum/geography/model/districtEntity.dart';
import 'package:komsum/geography/model/neighborhoodEntity.dart';
import 'package:komsum/geography/model/streetEntity.dart';
import 'package:komsum/helper/constants.dart';

class Geography extends Equatable {
  const Geography(this.id, this.name, this.type);

  final int id;
  final String name;
  final String type;

  @override
  List<Object> get props => [id, name, type];

  static Geography fromCityEntity(CityEntity entity) {
    return Geography(entity.id, entity.name, GeographyConst.city);
  }

  static Geography fromDistrictEntity(DistrictEntity entity) {
    return Geography(entity.id, entity.name, GeographyConst.district);
  }

  static Geography fromNeighborhoodEntity(NeighborhoodEntity entity) {
    return Geography(entity.id, entity.name, GeographyConst.neighborhood);
  }

  static Geography fromStreetEntity(StreetEntity entity) {
    return Geography(entity.id, entity.name, GeographyConst.street);
  }
}
