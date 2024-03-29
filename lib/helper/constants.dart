import 'package:flutter/cupertino.dart';

enum FilterType {
  GEOGRAPHY,
  TAG
}

class KomsumConst {
  // static const host = "10.0.2.2";
  // static const host = "10.0.2.2";
  // static const host = "46.101.87.81";
  // static const port = "STREET";
  // static const host = "localhost";
  static const KEYCLOAK_HOST = "192.168.1.103:8080";
  // static const KEYCLOAK_HOST = "localhost:8080";
  // static const API_HOST = "service.dev.komsumdannehaber.com";
  // static const API_HOST = "localhost:4000";
  static const API_HOST = "192.168.1.103:4000";
  static const PROTOCOL = "http";
  // static const PROTOCOL = "https";
}

class GeographyConst {
  static const street = "STREET";
  static const neighborhood = "NEIGHBORHOOD";
  static const district = "DISTRICT";
  static const city = "CITY";
  static const country = "COUNTRY";
}

class GeographyKeys {
  static final loadingGeographyList = const Key('loadingGeographyList');
  static final geographyList = const Key('geographyList');
  static final emptyGeographyListContainer= const Key('emptyGeographyListContainer');
}

class TagKeys {
  static final loadingTagList = const Key('loadingTagList');
  static final tagList = const Key('tagList');
  static final emptyTagListContainer= const Key('emptyTagListContainer');
}

class PostKeys {
  static final createPostPageScaffoldKey = const Key('createPostPageScaffoldKey');
  static final loadingCreatePost = const Key('loadingCreatePost');
  static final loadingPostList = const Key('loadingPostList');
}

class RouteNames {
  static const homePage = "/HomePage";
  static const createPostPage = "/CreatePostPage";
  static const profilePage = "/ProfilePage";
  static const picturePage = "/PicturePage";
}