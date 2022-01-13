
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/user/bloc/auth/authenticationBloc.dart';
import 'package:komsum/user/bloc/picture/pictureBarrel.dart';
import 'package:komsum/user/bloc/user/userBarrel.dart';
import 'package:http/http.dart' as http;
import 'package:komsum/user/model/keycloakUserEntity.dart';
import 'package:komsum/user/model/userRepresentation.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthenticationBloc authBloc;
  final http.Client httpClient = http.Client();
  final PictureBloc pictureBloc;

  StreamSubscription pictureSubscription;

  UserBloc({@required this.authBloc, @required this.pictureBloc}) : super(UserLoadInProgress()) {
    pictureSubscription = pictureBloc.stream.listen((state) {
      if(state is PictureUploadSuccess) {
        add(LoadUser(authBloc.state.user.subject));
      }
    });
  }


  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if(event is LoadUser) {
      yield* _mapUserLoadToState(event.username);
    }
  }

  Stream<UserState> _mapUserLoadToState(String username) async* {
    try {
      final user = await _fetchUser(username);
      yield UserLoadedSuccess(user);
    } catch (e) {
      print("_mapUserLoadToStateError");
      print(e);
      yield UserLoadedFailure();
    }
  }

  Future<KeycloakUserEntity> _fetchUser(String username) async {
    var token = authBloc.state.token.accessToken;
    Uri uri = KomsumConst.PROTOCOL == 'http' ? Uri.http(KomsumConst.API_HOST, '/user/' + username) : Uri.https(KomsumConst.API_HOST, '/user/' + username);
    final response = await httpClient.get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {

      return keycloakUserEntityFromJson(utf8.decode(response.bodyBytes));
    }

    throw Exception('error fetching User');
  }

  @override
  Future<void> close() {
    pictureSubscription.cancel();
    return super.close();
  }

}