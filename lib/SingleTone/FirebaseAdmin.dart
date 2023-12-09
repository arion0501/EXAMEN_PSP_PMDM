import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FirestoreObjects/FbPosts.dart';

class FirebaseAdmin {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FbPosts? selectedPost;

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
}
