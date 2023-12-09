import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  void checkSession() async {
    await Future.delayed(Duration(seconds: 3));

    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.of(context).popAndPushNamed("/homeview");
    } else
      Navigator.of(context).popAndPushNamed("/loginview");
  }

  @override
  Widget build(BuildContext context) {
    Column column = Column(
      children: [
        Image.asset('Recursos/aiGenerated.png', width: 500, height: 500),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        CircularProgressIndicator(),
      ],
    );
    return column;
  }
}
