import 'package:flutter/cupertino.dart';

class GeographyConst {
  static const street = "STREET";
  static const neighborhood = "NEIGHBORHOOD";
  static const district = "DISTRICT";
  static const city = "CITY";
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

class RouteNames {
  static const homePage = "HomePage";
}