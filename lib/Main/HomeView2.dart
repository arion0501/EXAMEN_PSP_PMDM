import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../FirestoreObjects/FbPosts.dart';
import '../OnBoarding/LoginView.dart';
import '../OnBoarding/SettingsView.dart';
import '../Personalizados/BottomBar.dart';
import '../Personalizados/DrawerCustom.dart';
import '../Personalizados/PostCellView.dart';
import '../Personalizados/PostGridCellView.dart';
import '../SingleTone/DataHolder.dart';

class HomeView2 extends StatefulWidget {
  @override
  State<HomeView2> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView2> {
  void fHomeViewDrawerOntap(int indice) {
    if (indice == 0) {
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginView()),
        ModalRoute.withName('/loginview'),
      );
    } else if (indice == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => HomeView2()),
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
        print('Post ' + i.toString());
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
