import 'package:equatable/equatable.dart';
import 'package:openid_client/openid_client.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationLoginRequested extends AuthenticationEvent {}

class AuthenticationRefreshRequested extends AuthenticationEvent {
  final UserInfo userInfo;
  final TokenResponse tokenResponse;

  const AuthenticationRefreshRequested(this.userInfo, this.tokenResponse);

  @override
  List<Object> get props => [userInfo, tokenResponse];
}