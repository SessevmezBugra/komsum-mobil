
import 'package:equatable/equatable.dart';
import 'package:komsum/geography/model/geography.dart';

abstract class GeographyListState extends Equatable {
  const GeographyListState();

  @override
  List<Object> get props => [];
}

class GeographyListLoadInProgress extends GeographyListState {}

class GeographyListLoadedSuccess extends GeographyListState {
  final List<Geography> geographies;

  const GeographyListLoadedSuccess([this.geographies = const []]);

  @override
  List<Object> get props => [geographies];

  @override
  String toString() => 'GeographyListLoadSuccess { geographies: $geographies }';
}

class GeographyListLoadFailure extends GeographyListState {}