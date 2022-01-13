import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/bloc/globalBlocObserver.dart';
import 'package:komsum/bloc/header/headerBarrel.dart';
import 'package:komsum/helper/common/loadingIndicator.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/bloc/create/createPostBarrel.dart';
import 'package:komsum/post/bloc/list/postListBarrel.dart';
import 'package:komsum/user/bloc/auth/authenticationBarrel.dart';
import 'package:komsum/user/bloc/picture/pictureBarrel.dart';
import 'package:komsum/user/bloc/user/userBarrel.dart';

import 'helper/routes.dart';
import 'package:http/http.dart' as http;
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/bloc/list/tagListBarrel.dart';
import 'geography/bloc/list/geographyListBarrel.dart';

void main() {
  Bloc.observer = GlobalBlocObserver();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) =>
          AuthenticationBloc()..add(AuthenticationLoginRequested()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GeographyListBloc>(
            create: (BuildContext context) => GeographyListBloc(
                authBloc: BlocProvider.of<AuthenticationBloc>(context))
              ..add(GeographyCityListLoad()),
          ),
          BlocProvider<TagListBloc>(
            create: (BuildContext context) => TagListBloc(
                authBloc: BlocProvider.of<AuthenticationBloc>(context))
              ..add(TagListLoad()),
          ),
          BlocProvider<TagFilterBloc>(
            create: (BuildContext context) => TagFilterBloc(),
          ),
          BlocProvider<GeographyFilterBloc>(
            create: (BuildContext context) => GeographyFilterBloc(),
          ),
          BlocProvider<CreatePostBloc>(
            create: (BuildContext context) => CreatePostBloc(
                authBloc: BlocProvider.of<AuthenticationBloc>(context)),
          ),
          BlocProvider<PostListBloc>(
            create: (BuildContext context) => PostListBloc(
              tagFilterBloc: BlocProvider.of<TagFilterBloc>(context),
              geographyFilterBloc:
                  BlocProvider.of<GeographyFilterBloc>(context),
              authBloc: BlocProvider.of<AuthenticationBloc>(context),
            )..add(PostListInitialLoad()),
          ),
          BlocProvider<PictureBloc>(
            create: (BuildContext context) => PictureBloc(
              authBloc: BlocProvider.of<AuthenticationBloc>(context),
            ),
          ),
          BlocProvider<UserBloc>(
            create: (BuildContext context) => UserBloc(
              authBloc: BlocProvider.of<AuthenticationBloc>(context),
              pictureBloc: BlocProvider.of<PictureBloc>(context),
            )..add(LoadUser(BlocProvider.of<AuthenticationBloc>(context)
                .state
                .user
                .preferredUsername)),
          ),
          BlocProvider<HeaderBloc>(
            create: (BuildContext context) => HeaderBloc()..add(HeaderPinned()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
      if (authState.status == AuthenticationStatus.authenticated) {
        return MaterialApp(
          title: 'Komsum',
          theme: ThemeData(
              primarySwatch: Colors.blue, backgroundColor: Colors.white),
          debugShowCheckedModeBanner: false,
          routes: Routes.route(),
          onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
          onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
          initialRoute: RouteNames.homePage,
        );
      } else {
        return LoadingIndicator();
      }
    });
  }
}
