import 'package:equatable/equatable.dart';
import 'package:komsum/user/model/keycloakUserEntity.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoadInProgress extends UserState {}

class UserLoadedSuccess extends UserState {
  final KeycloakUserEntity user;

  const UserLoadedSuccess(this.user);

  @override
  List<Object> get props => [this.user];
}

class UserLoadedFailure extends UserState {}