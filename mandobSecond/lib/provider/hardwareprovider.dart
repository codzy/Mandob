import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mandob/model/finish.dart';
import 'package:mandob/model/hardware.dart';

class HardwareProvider extends ChangeNotifier {
  Hardware hardware;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future deleteHardware(String w) async {
    await firebaseFirestore.collection("Hardware").doc(w).delete();
    print("deleted");
  }

  Future gotToEdit(
    Hardware w,
  ) {
    hardware = w;
    notifyListeners();
  }

  Future editHardware(String id, Hardware w) async {
    await firebaseFirestore.collection("Hardware").doc(id).update(w.toJson());
  }

  Future addHardware(Hardware p) async {
    await firebaseFirestore.collection("Hardware").add(p.toJson());
    notifyListeners();
  }

  Stream getItem(String uid) {
    return firebaseFirestore
        .collection("Hardware")
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream getUserItem() {
    return firebaseFirestore.collection("Hardware").snapshots();
  }
}
