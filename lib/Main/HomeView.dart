import 'dart:convert';
import 'package:examen_psp_pmdm_marcosgarcia/SingleTone/HttpAdmin.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../FirestoreObjects/FbPosts.dart';
import '../OnBoarding/LoginView.dart';
import '../OnBoarding/SettingsView.dart';
import '../Personalizados/BottomBar.dart';
import '../Personalizados/DrawerCustom.dart';
import '../Personalizados/PostCellView.dart';
import '../Personalizados/PostGridCellView.dart';
import '../SingleTone/DataHolder.dart';
import '../SingleTone/PilotoF1.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPosts> posts = [];
  bool bIsList = false;

  void onBottonMenuPressed(int indice) {
    print("--> HOME " + indice.toString() + "!!!");
    setState(() {
      if (indice == 0) {
        bIsList = true;
      } else if (indice == 1) {
        bIsList = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    descargarPosts();
    determinarTempLocal();
  }

  determinarTempLocal() async {
    Position position = await DataHolder().geolocAdmin.determinePosition();
    double valor = await DataHolder()
        .httpAdmin
        .pedirTemperaturasEn(position.latitude, position.longitude);
    print('La temperatura en el sitio donde estás es de: ${valor}' + ' ºC');
  }

  void getPilotosF1() async {
    int iAnio = 2022;
    final response = await http
        .get(Uri.parse('http://ergast.com/api/f1/${iAnio}/drivers.json'));

    if (response.statusCode == 200) {
      print("Prueba --->>   " + jsonDecode(response.body).toString());
      Map<String, dynamic> json = jsonDecode(response.body);
      Map<String, dynamic> json2 = json["Datos"];
      Map<String, dynamic> json3 = json2["Tabla Pilotos"];
      List<dynamic> listaPilotos = json3["Pilotos"];

      List<dynamic> listaPilotos2 = json["MRData"]["DriverTable"]["Drivers"];

      List<PilotoF1> listaPilotosFinal = [];

      for (int i = 0; i < listaPilotos2.length; i++) {
        listaPilotosFinal.add(PilotoF1.fromJson(listaPilotos2[i]));
      }

      print("Piloto en posición 17 (nombre) --->>: " +
          listaPilotosFinal[17].givenName +
          "   " +
          listaPilotosFinal[17].familyName);
    } else {
      throw Exception('Failed to load album');
    }
  }

  void descargarPosts() async {
    CollectionReference<FbPosts> reference = db
        .collection("Post")
        .withConverter(
            fromFirestore: FbPosts.fromFirestore,
            toFirestore: (FbPosts post, _) => post.toFirestore());
    QuerySnapshot<FbPosts> querySnap = await reference.get();
    for (int i = 0; i < querySnap.docs.length; i++) {
      setState(() {
        //print('Post ' + i.toString());
        posts.add(querySnap.docs[i].data());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text("Examen Home"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: celdasOLista(bIsList),
      ),
      bottomNavigationBar: BottomBar(evento: onBottonMenuPressed),
      drawer: DrawerCustom(onItemTap: fHomeViewDrawerOntap),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/postcreateview");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  void onItemListaClicked(int index) {
    DataHolder().selectedPost = posts[index];
    DataHolder().saveSelectedPostInCache();
    Navigator.of(context).pushNamed('/postview');
  }

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostCellView(
        sText: posts[index].titulo,
        dFontSize: 20,
        iColorCode: Colors.pink,
        iPosicion: index,
        onItemListClickedFun: onItemListaClicked);
  }

  Widget? creadorDeItemMatriz(BuildContext context, int index) {
    return PostGridCellView(
      post: posts,
      onItemListClickedFun: onItemListaClicked,
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return Column(
      children: [
        Divider(),
      ],
    );
  }

  Widget? celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    } else {
      return creadorDeItemMatriz(context, posts.length);
    }
  }
}
