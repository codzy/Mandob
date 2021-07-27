import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mandob/model/place.dart';

class PlacesProvider extends ChangeNotifier {
  Place place;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future deletePlace(String w) async {
    await firebaseFirestore.collection("place").doc(w).delete();
    print("deleted");

    //
  }

  Future gotToEdit(
    Place w,
  ) {
    place = w;
    notifyListeners();
  }

  Future editPlace(String id, Place w) async {
    await firebaseFirestore.collection("place").doc(id).update(w.toJson());
  }

  Future addPlace(Place p) async {
    await firebaseFirestore.collection("place").add(p.toJson());
    notifyListeners();
  }

  Stream getItem(String uid) {
    return firebaseFirestore
        .collection("place")
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream getUserItem() {
    return firebaseFirestore.collection("place").snapshots();
  }
}
