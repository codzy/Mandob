import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:mandob/model/user.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  Users userprofile;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<Users> getUserData(String userid) async {
    final user = await firebaseFirestore
        .collection("user")
        .where("uid", isEqualTo: userid)
        .get();

    userprofile = Users.fromJson(user.docs[0]);
    notifyListeners();
    return userprofile;
  }

  Future saveUserData(Users user) async {
    await firebaseFirestore.collection("user").add(user.toJson());
  }
}
