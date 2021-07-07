import 'package:equatable/equatable.dart';
import 'package:komsum/geography/model/geography.dart';

abstract class GeographyFilterEvent extends Equatable {
  const GeographyFilterEvent();

  @override
  List<Object> get props => [];
}

class GeographyFilterAdded extends GeographyFilterEvent {
  final Geography geography;
  const GeographyFilterAdded(this.geography);

  @override
  List<Object> get props => [geography];
}

class GeographyFilterRemoved extends GeographyFilterEvent {
  final Geography geography;
  const GeographyFilterRemoved(this.geography);


  @override
  List<Object> get props => [geography];
}