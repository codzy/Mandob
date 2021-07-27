import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mandob/model/finish.dart';

class FinishingProvider extends ChangeNotifier {
  Finishing finishing;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future deleteFinishing(String w) async {
    await firebaseFirestore.collection("Finishing").doc(w).delete();
    print("deleted");
  }

  Future gotToEdit(
    Finishing w,
  ) {
    finishing = w;
    notifyListeners();
  }

  Future editFinishing(String id, Finishing w) async {
    await firebaseFirestore.collection("Finishing").doc(id).update(w.toJson());
  }

  Future addFinishing(Finishing p) async {
    await firebaseFirestore.collection("Finishing").add(p.toJson());
    notifyListeners();
  }

  Stream getItem(String uid) {
    return firebaseFirestore
        .collection("Finishing")
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream getUserItem() {
    return firebaseFirestore.collection("Finishing").snapshots();
  }
}
