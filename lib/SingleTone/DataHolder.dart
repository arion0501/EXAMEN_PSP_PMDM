import 'package:cloud_firestore/cloud_firestore.dart';
import 'FirebaseAdmin.dart';

class DataHolder {
  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbAdmin = FirebaseAdmin();

  factory DataHolder() {
    return _dataHolder;
  }

  DataHolder._internal();
}
