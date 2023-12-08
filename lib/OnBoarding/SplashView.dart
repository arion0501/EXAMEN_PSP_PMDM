import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    Column column = Column(
      children: [
        Image.asset('Recursos/aiGenerated.png', width: 50, height: 50),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        CircularProgressIndicator(),
      ],
    );
    return column;
  }
}
