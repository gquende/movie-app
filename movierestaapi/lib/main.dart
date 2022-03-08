import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movierestaapi/pages/main_page.dart';
import 'package:movierestaapi/pages/splash_page.dart';

void main() {
  runApp(SplashPage(
      onInitilizationComplete: () => runApp(ProviderScope(child: MyApp()))));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GQ Quende',
      initialRoute: 'home',
      routes: {
        'home': (
          BuildContext ctx,
        ) =>
            MainPage()
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}