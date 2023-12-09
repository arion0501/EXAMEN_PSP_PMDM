import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FirestoreObjects/FbPosts.dart';
import 'FirebaseAdmin.dart';

class DataHolder {
  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  String sNombre = "DataHolder Examen";
  late String sPostTitle;
  FbPosts? selectedPost;

  factory DataHolder() {
    return _dataHolder;
  }

  void initDataHolder() {
    sPostTitle = "Titulo de Post";
  }

  Future<FbPosts?> initCachedFbPost() async {
    if (selectedPost != null) return selectedPost;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpost_titulo = prefs.getString('titulo');
    fbpost_titulo ??= "";

    String? fbpost_cuerpo = prefs.getString('cuerpo');
    fbpost_cuerpo ??= "";

    String? fbpost_imagen = prefs.getString('imagen');
    fbpost_imagen ??= "";

    selectedPost = FbPosts(
        titulo: fbpost_titulo, cuerpo: fbpost_cuerpo, imagen: fbpost_imagen);

    return selectedPost;
  }

  DataHolder._internal() {
    initCachedFbPost();
  }
}
