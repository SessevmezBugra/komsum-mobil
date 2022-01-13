import 'package:equatable/equatable.dart';

abstract class HeaderEvent extends Equatable {
  const HeaderEvent();

  @override
  List<Object> get props => [];
}

class HeaderPinned extends HeaderEvent {}

class HeaderNotPinned extends HeaderEvent {}