import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:komsum/user/bloc/authenticationBarrel.dart';
import 'package:komsum/user/bloc/authenticationEvent.dart';
import 'package:komsum/user/model/User.dart';
import 'package:openid_client/openid_client_io.dart' as oidc;
import 'package:url_launcher/url_launcher.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState.unauthenticated());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationLogoutRequested) {
      yield _logOut();
    } else if (event is AuthenticationLoginRequested) {
      yield* _logIn();
    } else if (event is AuthenticationRefreshRequested) {
      yield AuthenticationState.authenticated(event.userInfo, event.tokenResponse);
    } else {
      yield AuthenticationState.unauthenticated();
    }
  }

  Stream<AuthenticationState> _logIn() async* {
    var _storage = FlutterSecureStorage();
    oidc.Credential credential;
    bool refreshFail = false;
    bool accessTokenSaved = await _storage.read(key: 'accessToken') != null;
    var clientId = 'ui-app';
    urlLauncher(String url) async {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: true);
      } else {
        throw 'Could not launch $url';
      }
    }
    oidc.TokenResponse tokenResponse;
    oidc.UserInfo userInfo;

    if (accessTokenSaved) {
      print("login using saved token");
      final tt = await _storage.read(key: 'tokenType');
      final rt = await _storage.read(key: 'refreshToken');
      final it = await _storage.read(key: 'idToken');

      var issuer = await oidc.Issuer.discover(Uri.parse('https://auth.dev.komsumdannehaber.com/auth/realms/komsumdannehaber'));

      var client = new oidc.Client(issuer, clientId);
      credential = client.createCredential(
        accessToken: null, // force use refresh to get new token
        tokenType: tt,
        refreshToken: rt,
        idToken: it,
      );

      credential.validateToken(validateClaims: true, validateExpiry: true);

      try {
        tokenResponse = await credential.getTokenResponse();
        userInfo = await credential.getUserInfo();
        await _storage.write(key: 'tokenType', value: tokenResponse.tokenType);
        await _storage.write(key: 'refreshToken', value: tokenResponse.refreshToken);
        await _storage.write(key: 'idToken', value: tokenResponse.idToken.toCompactSerialization());
        await _storage.write(key: 'accessToken', value: tokenResponse.accessToken);
      } catch (e) {
        print("Error during login (refresh) " + e.toString());
        refreshFail = true;
      }
    }

    if (!accessTokenSaved || refreshFail) {
      var issuer = await oidc.Issuer.discover(Uri.parse('https://auth.dev.komsumdannehaber.com/auth/realms/komsumdannehaber'));
      var client = new oidc.Client(issuer, clientId);
      //auth from browser
      var authenticator = oidc.Authenticator(
        client,
        scopes: List<String>.of(['openid', 'profile', 'offline_access']),
        port: 8081,
        urlLancher: urlLauncher,
      );
      credential = await authenticator.authorize();
      closeWebView();
      //save Token
      tokenResponse = await credential.getTokenResponse();
      userInfo = await credential.getUserInfo();

      await _storage.write(key: 'tokenType', value: tokenResponse.tokenType);
      await _storage.write(key: 'refreshToken', value: tokenResponse.refreshToken);
      await _storage.write(key: 'idToken', value: tokenResponse.idToken.toCompactSerialization());
      await _storage.write(key: 'accessToken', value: tokenResponse.accessToken);
    }

    // customGetTokenResponse() async {
    //   tokenResponse = await credential.getTokenResponse();
    //   userInfo = await credential.getUserInfo();
    //   print("called getTokenResponse, token expiration:" +
    //       tokenResponse.expiresAt.toIso8601String());
    //   await _storage.write(key: 'tokenType', value: tokenResponse.tokenType);
    //   await _storage.write(key: 'refreshToken', value: tokenResponse.refreshToken);
    //   await _storage.write(key: 'idToken', value: tokenResponse.idToken.toCompactSerialization());
    //   await _storage.write(key: 'accessToken', value: tokenResponse.accessToken);
    //   return tokenResponse;
    // }

    Timer.periodic(new Duration(seconds: 10), (timer) async {
      try {
        if(!refreshFail) {
          var currentDate = new DateTime.now();
          var remainingTime = tokenResponse.expiresAt.difference(currentDate);
          // print("remaining time " + remainingTime.toString());
          if(remainingTime < Duration(seconds: 70)) {
            tokenResponse = await credential.getTokenResponse(true);
            userInfo = await credential.getUserInfo();
            // print("called getTokenResponse, token expiration:" +
            //     tokenResponse.expiresAt.toIso8601String());
            await _storage.write(key: 'tokenType', value: tokenResponse.tokenType);
            await _storage.write(key: 'refreshToken', value: tokenResponse.refreshToken);
            await _storage.write(key: 'idToken', value: tokenResponse.idToken.toCompactSerialization());
            await _storage.write(key: 'accessToken', value: tokenResponse.accessToken);
            // print("Token expired in 70 seconds");
            add(AuthenticationRefreshRequested(userInfo, tokenResponse));
          }
        }
      } catch(e) {
        print(e);
      }

    });

    // var http = HttpFunctions()..getTokenResponseFn = customGetTokenResponse;
    // var uri = Uri.parse('https://auth.dev.komsumdannehaber.com/auth/realms/komsumdannehaber');
    //
    // var scopes = List<String>.of(['profile']);
    //
    // var issuer = await Issuer.discover(uri);
    // var client = new Client(issuer, clientId);
    //
    // var authenticator = new Authenticator(
    //     client,
    //     scopes: scopes,
    //     urlLancher: urlLauncher
    // );
    //
    // TokenResponse token;
    // UserInfo user;
    //   var c = await authenticator.authorize().catchError((e){
    //     print(e);
    //   });
    //   closeWebView();
    //   token= await c.getTokenResponse();
    //   user = await c.getUserInfo();
    yield AuthenticationState.authenticated(userInfo, tokenResponse);
  }

  _logOut() {

  }

}