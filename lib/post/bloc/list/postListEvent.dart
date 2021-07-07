import 'package:equatable/equatable.dart';

abstract class PostListEvent extends Equatable {
  const PostListEvent();
  @override
  List<Object> get props => [];
}

class PostListFetched extends PostListEvent {

  final int page;
  final int cityId;
  final int districtId;
  final int neighborhoodId;
  final int streetId;
  final List<int> tagIds;

  const PostListFetched(this.page, this.cityId, this.districtId, this.neighborhoodId, this.streetId, this.tagIds);

  @override
  List<Object> get props => [page, cityId, districtId, neighborhoodId, streetId, tagIds];
}