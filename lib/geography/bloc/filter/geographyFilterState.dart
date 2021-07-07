import 'package:equatable/equatable.dart';
import 'package:komsum/geography/model/geography.dart';


class GeographyFilterState  extends Equatable {

  final List<Geography> geographyFilterList;

  const GeographyFilterState([this.geographyFilterList = const [] ]);

  GeographyFilterState copyWith(List<Geography> geographyFilterList) {
    return GeographyFilterState(
      geographyFilterList ?? this.geographyFilterList
    );
  }

  @override
  List<Object> get props => [geographyFilterList];
}