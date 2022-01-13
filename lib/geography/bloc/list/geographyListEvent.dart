
import 'package:equatable/equatable.dart';
import 'package:komsum/geography/model/geography.dart';

abstract class GeographyListEvent extends Equatable {
  const GeographyListEvent();

  @override
  List<Object> get props => [];
}

class GeographyCityListLoad extends GeographyListEvent {}

class GeographyDistrictListLoad extends GeographyListEvent {
  final Geography geography;
  const GeographyDistrictListLoad(this.geography);
  @override
  List<Object> get props => [geography];
}

class GeographyNeighborhoodListLoad extends GeographyListEvent {
  final Geography geography;
  const GeographyNeighborhoodListLoad(this.geography);
  @override
  List<Object> get props => [geography];
}

class GeographyStreetListLoad extends GeographyListEvent {
  final Geography geography;
  const GeographyStreetListLoad(this.geography);
  @override
  List<Object> get props => [geography];
}

class GeographyEmptyListLoad extends GeographyListEvent {}


