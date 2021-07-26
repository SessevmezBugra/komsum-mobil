import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/bloc/create/createPostBarrel.dart';
import 'package:komsum/post/model/post.dart';

import 'package:http/http.dart' as http;

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {

  CreatePostBloc() : super(PostCreatedInInitialize());

  @override
  Stream<CreatePostState> mapEventToState(CreatePostEvent event) async* {
    print('1');
    if (event is PostCreated) {
      yield* _mapPostCreatedToState(event.post, event.file);
    }
  }

  Stream<CreatePostState> _mapPostCreatedToState(Post post, File file) async* {
    try {
      print('2');
      yield PostCreatedInProgress();
      await _createPost(post, file);
      yield PostCreatedSuccess();
    } catch (_) {
      print(_);
      yield PostCreatedFailure();
    }
  }

  Future _createPost(Post post, File file) async {

        var stream = new http.ByteStream(file.openRead());
        var length = await file.length();
        var host = KomsumConst.host;
        var uri = Uri.parse('http://$host:8091/post');
        var request = new http.MultipartRequest("POST", uri);
        var multipartFile = new http.MultipartFile('file', stream, length,
            filename: file.path);

        request.files.add(multipartFile);
        request.fields['body'] = postToJson(post);
        var response = await request.send();
        // print(response.statusCode);
        // response.stream.transform(utf8.decoder).listen((value) {
        //   print(value);
        // });
  }
}
