import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/bloc/globalBlocObserver.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/bloc/create/createPostBarrel.dart';
import 'package:komsum/post/bloc/list/postListBarrel.dart';

import 'helper/routes.dart';
import 'package:http/http.dart' as http;
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/bloc/list/tagListBarrel.dart';
import 'geography/bloc/list/geographyListBarrel.dart';

void main() {
  Bloc.observer = GlobalBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<GeographyListBloc>(
        create: (BuildContext context) =>
            GeographyListBloc(httpClient: http.Client())
              ..add(GeographyCityListLoad()),
      ),
      BlocProvider<TagListBloc>(
        create: (BuildContext context) =>
            TagListBloc(httpClient: http.Client())..add(TagListLoad()),
      ),
      BlocProvider<TagFilterBloc>(
        create: (BuildContext context) => TagFilterBloc(),
      ),
      BlocProvider<GeographyFilterBloc>(
        create: (BuildContext context) => GeographyFilterBloc(),
      ),
      BlocProvider<CreatePostBloc>(
        create: (BuildContext context) => CreatePostBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Komsum',
      theme:
          ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      routes: Routes.route(),
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
      initialRoute: RouteNames.homePage,
    );
  }
}
