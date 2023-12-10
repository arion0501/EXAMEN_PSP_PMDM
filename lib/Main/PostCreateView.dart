import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_psp_pmdm_marcosgarcia/Personalizados/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../FirestoreObjects/FbPosts.dart';
import '../Personalizados/CustomButton.dart';
import '../SingleTone/DataHolder.dart';

class PostCreateView extends StatefulWidget {
  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecTitulo = TextEditingController();
  TextEditingController tecCuerpo = TextEditingController();
  TextEditingController tecImagen = TextEditingController();

  ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");

  void subirPost() async {
    final storageRef = FirebaseStorage.instance.ref();

    String rutaEnNube = "posts/" +
        FirebaseAuth.instance.currentUser!.uid +
        "/imgs/" +
        DateTime
            .now()
            .millisecondsSinceEpoch
            .toString() +
        ".jpg";

    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);

    final metadata = SettableMetadata(contentType: "image/jpeg");

    //--INICIO DE SUBIDA DE IMAGEN
    try {
      await rutaAFicheroEnNube.putFile(_imagePreview, metadata);
    } on FirebaseException catch (e) {
      print("Error al subir la imagen" + e.toString());
    }
    print("Imagen subida con éxito");

    String imgUrl = await rutaAFicheroEnNube.getDownloadURL();
    print("URL de descarga: " + imgUrl);
    //-- FIN DE SUBIDA DE IMAGEN

    //-- INICIO SUBIDA DE POST
    FbPosts postNuevo = new FbPosts(
        titulo: tecTitulo.text, cuerpo: tecCuerpo.text, imagen: imgUrl);

    DataHolder().crearPostEnFB(postNuevo);
    //-- FIN SUBIDA DE POST
    Navigator.of(context).popAndPushNamed("/homeview");
  }

  void onGalleryClicked() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void onCameraClicked() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
        appBar: AppBar(title: Text(DataHolder().sNombre),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                  tecController: tecTitulo, labelText: 'Escribe un titulo'),
              CustomTextField(
                  tecController: tecCuerpo, labelText: 'Escribe un cuerpo'),
              if (_imagePreview.path != "")
                Image.file(_imagePreview, width: 250, height: 250),
              Row(children: [
                CustomButton(onPressed: onGalleryClicked, labelText: "Galería"),
                CustomButton(onPressed: onCameraClicked, labelText: "Cámara"),
              ]),
              CustomButton(onPressed: subirPost, labelText: "Postear")
            ],
          ),
        ));
  }
}
