import 'package:equatable/equatable.dart';

abstract class PictureState extends Equatable {
  const PictureState();

  @override
  List<Object> get props => [];
}

class PictureUploadInitial extends PictureState {}

class PictureUploadInProgress extends PictureState {}

class PictureUploadSuccess extends PictureState {
  final String pictureId;
  const PictureUploadSuccess(this.pictureId);

  @override
  List<Object> get props => [this.pictureId];
}

class PictureUploadFailure extends PictureState {}