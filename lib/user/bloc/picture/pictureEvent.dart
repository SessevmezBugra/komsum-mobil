import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class PictureEvent extends Equatable {
  const PictureEvent();

  @override
  List<Object> get props => [];
}

class UploadPicture extends PictureEvent {
  final File file;

  const UploadPicture(this.file);

  @override
  List<Object> get props => [file];
}