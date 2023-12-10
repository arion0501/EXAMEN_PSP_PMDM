import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Main/HomeView.dart';
import '../Personalizados/DrawerCustom.dart';
import 'LoginView.dart';

class SettingsView extends StatefulWidget {
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text('Ajustes'),
      centerTitle: true,
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
    );

    Scaffold scaf = Scaffold(
      backgroundColor: Colors.indigo,
      appBar: appBar,
      drawer: DrawerCustom(onItemTap: fHomeViewDrawerOntap),
    );

    return scaf;
  }

  void fHomeViewDrawerOntap(int indice) {
    if (indice == 0) {
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginView()),
        ModalRoute.withName('/loginview'),
      );
    } else if (indice == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => HomeView()),
        ModalRoute.withName('/homeview'),
      );
    } else if (indice == 2) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => SettingsView()),
        ModalRoute.withName('/settingsview'),
      );
    }
  }
}
