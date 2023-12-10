import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FirestoreObjects/FbPosts.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';
import 'HttpAdmin.dart';

class DataHolder {
  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  GeolocAdmin geolocAdmin = GeolocAdmin();
  HttpAdmin httpAdmin = HttpAdmin();

  String sNombre = "DataHolder Examen";
  late String sPostTitle;
  FbPosts? selectedPost;

  DataHolder._internal() {
    initCachedFbPost();
  }

  void initDataHolder() {
    sPostTitle = "Titulo de Post";
  }

  factory DataHolder() {
    return _dataHolder;
  }

  void crearPostEnFB(FbPosts post) {
    CollectionReference<FbPosts> postRef = db.collection("Post").withConverter(
        fromFirestore: FbPosts.fromFirestore,
        toFirestore: (FbPosts post, _) => post.toFirestore());

    postRef.add(post);
  }

  void saveSelectedPostInCache() async {
    if (selectedPost != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('titulo', selectedPost!.titulo);
      prefs.setString('cuerpo', selectedPost!.cuerpo);
      prefs.setString('imagen', selectedPost!.imagen);
    }
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
}
