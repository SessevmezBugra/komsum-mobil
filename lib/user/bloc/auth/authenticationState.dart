import 'package:equatable/equatable.dart';
import 'package:openid_client/openid_client_io.dart';

enum AuthenticationStatus { inProgress, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unauthenticated,
    this.user,
    this.token
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(UserInfo user, token)
      : this._(status: AuthenticationStatus.authenticated, user: user, token: token);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final UserInfo user;
  final TokenResponse token;

  @override
  List<Object> get props => [status, user];
}