import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/bloc/create/createPostBarrel.dart';
import 'package:komsum/post/model/post.dart';

import 'package:http/http.dart' as http;
import 'package:komsum/user/bloc/auth/authenticationBarrel.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {

  final AuthenticationBloc authBloc;

  CreatePostBloc({@required this.authBloc}) : super(PostCreatedInInitialize());

  @override
  Stream<CreatePostState> mapEventToState(CreatePostEvent event) async* {

    if (event is PostCreated) {
      yield* _mapPostCreatedToState(event.post, event.file);
    }
  }

  Stream<CreatePostState> _mapPostCreatedToState(Post post, Uint8List file) async* {
    try {

      yield PostCreatedInProgress();
      await _createPost(post, file);
      yield PostCreatedSuccess();
    } catch (_) {
      print(_);
      yield PostCreatedFailure();
    }
  }

  Future _createPost(Post post, Uint8List uint8list) async {

        var stream = new http.ByteStream(Stream.value(
          List<int>.from(uint8list),
        ));
        var length =  uint8list.length;
        var token = authBloc.state.token.accessToken;
        Uri uri = KomsumConst.PROTOCOL == 'http' ? Uri.http(KomsumConst.API_HOST, '/post') : Uri.https(KomsumConst.API_HOST, '/post');
        var request = new http.MultipartRequest("POST", uri)..headers.addAll(
            {
              'Authorization': 'Bearer $token',
            });
        var multipartFile = new http.MultipartFile('file', stream, length,
        filename: 'komsumapp');

        request.files.add(multipartFile);
        request.fields['body'] = postToJson(post);
        var response = await request.send();
        // print(response.statusCode);
        // response.stream.transform(utf8.decoder).listen((value) {
        //   print(value);
        // });
  }
}
