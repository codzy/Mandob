import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mandob/Screens/workinghanditem.dart';
import 'package:mandob/model/product.dart';
import 'package:mandob/model/workinghand.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductProvider extends ChangeNotifier {
  Product product;
  File img;
  String imgname;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future deleteProduct(String w) async {
    await firebaseFirestore.collection("product").doc(w).delete();
    print("deleted");
  }

  Future gotToEdit(
    Product w,
  ) {
    product = w;
    notifyListeners();
  }

  Future editProduct(String id, Product w) async {
    await firebaseFirestore.collection("product").doc(id).update(w.toJson());
  }

  Future addProduct(Product p) async {
    await firebaseFirestore.collection("product").add(p.toJson());
    notifyListeners();
  }

  Stream getItem(String uid) {
    return firebaseFirestore
        .collection("product")
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  Stream getUserItem(String cat) {
    if (["cars", "mobiles", "clothes"].contains(cat)) {
      print("Category is chooosen successfully !");
      return firebaseFirestore
          .collection("product")
          .where("cat", isEqualTo: cat)
          .snapshots();
    } else {
      print("Category is NOT CHOOSEN !");
      return firebaseFirestore.collection("product").snapshots();
    }
  }
}
