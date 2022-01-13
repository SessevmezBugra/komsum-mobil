import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/homePage.dart';
import 'package:komsum/post/view/createPostPage.dart';
import 'package:komsum/user/bloc/auth/authenticationBarrel.dart';
import 'package:komsum/user/bloc/picture/pictureBarrel.dart';
import 'package:komsum/user/bloc/post/userPostBloc.dart';
import 'package:komsum/user/bloc/post/userPostEvent.dart';
import 'package:komsum/user/bloc/user/userBarrel.dart';
import 'package:komsum/user/bloc/user/userBloc.dart';
import 'package:komsum/user/view/picturePage.dart';
import 'package:komsum/user/view/profilePage.dart';
import 'package:komsum/widgets/customWidgets.dart';

import 'customRoute.dart';

class Routes {
  static dynamic route() {
    return {RouteNames.homePage: (BuildContext context) => HomePage()};
  }

  static Route onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch ('/' + pathElements[1]) {
      case RouteNames.homePage:
        return CustomRoute<bool>(builder: (BuildContext context) => HomePage());
      case RouteNames.createPostPage:
        return CustomRoute<bool>(
            builder: (BuildContext context) => CreatePostPage());
      case RouteNames.profilePage:
        return CustomRoute<bool>(
            builder: (BuildContext context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<UserPostListBloc>(
                      create: (BuildContext context) => UserPostListBloc(
                        authBloc: BlocProvider.of<AuthenticationBloc>(context),
                      )..add(LoadInitialUserPostList(pathElements[2])),
                      child: ProfilePage(pathElements[2]),
                    ),
                    BlocProvider<UserBloc>(
                      create: (BuildContext context) => UserBloc(
                        authBloc: BlocProvider.of<AuthenticationBloc>(context),
                        pictureBloc: BlocProvider.of<PictureBloc>(context),
                      )..add(LoadUser(pathElements[2])),
                    ),
                  ],
                  child: ProfilePage(pathElements[2]),
                ));
      case RouteNames.picturePage:
        return CustomRoute<bool>(
          builder: (BuildContext context) =>
              PicturePage(pathElements.length > 1 ? pathElements[2] : ''),
        );
      default:
        return CustomRoute<bool>(builder: (BuildContext context) => HomePage());
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
