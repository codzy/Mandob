import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mandob/Screens/workinghanditem.dart';
import 'package:mandob/model/workinghand.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class WorkingHandProvider extends ChangeNotifier {
  WorkingHand workingHand;

  File img;
  String imgname;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future deleteResumee(String w) async {
    await firebaseFirestore.collection("workinghand").doc(w).delete();
    print("deleted");
  }

  Future gotToEdit(
    WorkingHand w,
  ) {
    workingHand = w;
    notifyListeners();
  }

  Future editResumee(String id, WorkingHand w) async {
    await firebaseFirestore
        .collection("workinghand")
        .doc(id)
        .update(w.toJson());
  }

  Future addHandWork(WorkingHand p) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    await firebaseFirestore.collection("workinghand").add(p.toJson());
    notifyListeners();
  }

  Stream getItem(String uid) {
    return firebaseFirestore
        .collection("workinghand")
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream getUserItem(String cat) {
    if (["cars", "mobiles", "clothes"].contains(cat)) {
      print("Category is chooosen successfully !");
      return firebaseFirestore
          .collection("workinghand")
          .where("work", isEqualTo: cat)
          .snapshots();
    } else {
      print("Category is NOT CHOOSEN !");
      return firebaseFirestore.collection("workinghand").snapshots();
    }
  }
}
