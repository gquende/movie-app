import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:movierestaapi/models/app_config.dart';
import 'package:movierestaapi/services/http_service.dart';
import 'package:movierestaapi/services/movie_services.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitilizationComplete;

  const SplashPage({Key key, @required this.onInitilizationComplete})
      : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 1)).then((_) =>
        _setup(context).then((value) => widget.onInitilizationComplete()));
    super.initState();
  }

  //Funcao de configuracao da App
  Future<void> _setup(BuildContext context) async {
    final GetIt getIt = GetIt.instance();
    final configFile = await rootBundle.loadString("assets/config/main.json");
    final configData = jsonDecode(configFile);

    getIt.registerSingleton<AppConfig>(AppConfig(
        API_KEY: configData['API_KEY'],
        BASE_API_URL: configData['BASE_API_URL'],
        BASE_IMAGE_API_URL: configData['BASE_IMAGE_URL']));

    getIt.registerSingleton<HTTPService>(HTTPService());
    getIt.registerSingleton<MovieService>(MovieService());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          child: Icon(
            Icons.category,
            color: Colors.blue,
            size: 100,
          ),
        ),
      ),
    );
  }
}