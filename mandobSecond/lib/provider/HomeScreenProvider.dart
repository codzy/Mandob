import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenProvider with ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream getPlaces() {
    return firebaseFirestore.collection("place").snapshots();
  }

  Stream getFinishing() {
    return firebaseFirestore.collection("finishing").snapshots();
  }

  Stream getHardware() {
    return firebaseFirestore.collection("Hardware").snapshots();
  }

  Stream getProduct() {
    return firebaseFirestore.collection("product").snapshots();
  }
}
