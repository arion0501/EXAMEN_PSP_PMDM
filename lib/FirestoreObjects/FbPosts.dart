import 'package:cloud_firestore/cloud_firestore.dart';

class FbPosts {
  final String titulo;
  final String cuerpo;
  final String imagen;

  FbPosts({
    required this.titulo,
    required this.cuerpo,
    required this.imagen,
  });

  factory FbPosts.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return FbPosts(
      titulo: data?['Titulo'],
      cuerpo: data?['Cuerpo'],
      imagen: data?['Imagen'],
    );
  }

  static Future<FbPosts> updatePost(FirebaseFirestore db, String uid,
      String nuevoTitulo, String nuevoCuerpo) async {
    await db.collection("Post").doc(uid).update({
      "titulo": nuevoTitulo,
      "cuerpo": nuevoCuerpo,
    });

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Post").doc(uid).get();
    FbPosts postActualizado = FbPosts.fromFirestore(snapshot, null);

    return postActualizado;
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "Titulo": titulo,
      if (cuerpo != null) "Cuerpo": cuerpo,
      if (imagen != null) "Imagen": imagen,
    };
  }
}
