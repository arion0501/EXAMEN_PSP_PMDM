import 'package:examen_psp_pmdm_marcosgarcia/Main/PostCreateView.dart';
import 'package:examen_psp_pmdm_marcosgarcia/Main/PostView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Main/HomeView.dart';
import 'Main/HomeView2.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';
import 'OnBoarding/SettingsView.dart';
import 'OnBoarding/SplashView.dart';

class ExamenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp;

    if (kIsWeb) {
      materialApp = MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Examen App",
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView(),
          '/splashview': (context) => SplashView(),
          '/settingsview': (context) => SettingsView(),
          '/postview': (context) => PostView(),
          '/postcreateview': (context) => PostCreateView()
        },
        initialRoute: '/splashview',
      );
    } else
      materialApp = MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Examen App",
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView2(),
          '/splashview': (context) => SplashView(),
          '/settingsview': (context) => SettingsView(),
          '/postview': (context) => PostView(),
          '/postcreateview': (context) => PostCreateView()
        },
        initialRoute: '/splashview',
      );
    return materialApp;
  }
}
