import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/user/bloc/auth/authenticationBloc.dart';
import 'package:komsum/user/bloc/picture/pictureBarrel.dart';
import 'package:http/http.dart' as http;

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  final AuthenticationBloc authBloc;
  final http.Client httpClient = http.Client();

  PictureBloc({@required this.authBloc}) : super(PictureUploadInitial());

  @override
  Stream<PictureState> mapEventToState(PictureEvent event) async* {
    if(event is UploadPicture) {
      yield* _mapUploadPictureToState(event.file);
    }
  }

  Stream<PictureState> _mapUploadPictureToState(File file) async* {
    try {
      yield PictureUploadInProgress();
      final pictureId = await _uploadFile(file);
      yield PictureUploadSuccess(pictureId);
    } catch (e) {
      print(e);
      yield PictureUploadFailure();
    }
  }

  Future<String> _uploadFile(File file) async {

    var stream = new http.ByteStream(file.openRead());
    var length = await file.length();
    var token = authBloc.state.token.accessToken;
    Uri uri = KomsumConst.PROTOCOL == 'http' ? Uri.http(KomsumConst.API_HOST, '/file/profile-picture') : Uri.https(KomsumConst.API_HOST, '/file/profile-picture');
    var request = new http.MultipartRequest("POST", uri)..headers.addAll(
        {
          'Authorization': 'Bearer $token',
        });
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: file.path);

    request.files.add(multipartFile);
    var response = await request.send();
    String pictureId = await response.stream.transform(utf8.decoder).first;
    return pictureId;
  }

}