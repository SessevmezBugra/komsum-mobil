import 'package:flutter/material.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/homePage.dart';
import 'package:komsum/post/view/createPostPage.dart';
import 'package:komsum/widgets/customWidgets.dart';

import 'customRoute.dart';

class Routes {

  static dynamic route() {
    return {
      RouteNames.homePage: (BuildContext context) => HomePage()
    };
  }

  static Route onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch ('/' + pathElements[1]) {
      case RouteNames.homePage:
        return CustomRoute<bool>(
            builder: (BuildContext context) => HomePage());
      case RouteNames.createPostPage:
        return CustomRoute<bool>(
            builder: (BuildContext context) => CreatePostPage());
      default:
        return onUnknownRoute(RouteSettings(name: RouteNames.homePage));
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: customTitleText("Komsum"),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Comming soon..'),
        ),
      ),
    );
  }
}