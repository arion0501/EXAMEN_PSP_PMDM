import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Main/HomeView.dart';
import 'Main/HomeView2.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';
import 'OnBoarding/SplashView.dart';

class ExamenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp;
    if (kIsWeb) {
      materialApp = MaterialApp(
        title: "Examen App",
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview':(context) => HomeView(),
          '/splashview': (context) => SplashView(),
        },
        initialRoute: '/splashview',
      );
    } else
      materialApp = MaterialApp(
        title: "Examen App",
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview':(context) => HomeView2(),
          '/splashview': (context) => SplashView(),
        },
        initialRoute: '/splashview',
      );
    return materialApp;
  }
}
