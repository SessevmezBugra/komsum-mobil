import 'package:flutter/cupertino.dart';

enum FilterType {
  GEOGRAPHY,
  TAG
}

class KomsumConst {
  // static const host = "10.0.2.2";
  // static const host = "10.0.2.2";
  static const host = "46.101.87.81";
  static const port = "STREET";
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
}