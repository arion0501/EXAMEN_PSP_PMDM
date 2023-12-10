
import 'package:examen_psp_pmdm_marcosgarcia/Personalizados/CustomButton.dart';
import 'package:flutter/material.dart';
import '../FirestoreObjects/FbPosts.dart';
import '../SingleTone/DataHolder.dart';

class PostView extends StatefulWidget {
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  FbPosts _datosPost =
      FbPosts(titulo: "titulo", cuerpo: "cuerpo", imagen: "imagen");

  @override
  void initState() {
    super.initState();
    cargarPostGuardadoEnCache();
  }

  void cargarPostGuardadoEnCache() async {
    var temp1 = await DataHolder().initCachedFbPost();

    setState(() {
      _datosPost = temp1!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
          title: Text(DataHolder().sNombre),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white),
      body: Column(
        children: [
          Text(_datosPost.titulo),
          Text(_datosPost.cuerpo),
          Image.network(_datosPost.imagen, width: 70, height: 70),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          CustomButton(onPressed: () {}, labelText: "Editar")
        ],
      ),
    );
  }
}
