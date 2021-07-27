import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandob/Screens/UserNotification.dart';
import 'package:mandob/model/cart.dart';
import 'package:mandob/model/user.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:mandob/widgets/customwidgets.dart';
import '../Screens/UserNotification.dart';
import 'package:provider/provider.dart';
import '../provider/NotificationProvider.dart';

class CartProvider extends ChangeNotifier {
  Cart cart;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future goToEdit(Cart c) async {
    cart = c;
    notifyListeners();
  }

  Future editCart(Cart ob, String id) async {
    final x = await firebaseFirestore
        .collection("Cart")
        .where("pid", isEqualTo: ob.pid)
        .get();
    final d = x.docs;
    print(ob.pid);
    print(d.length != 0);
    if (d.length != 0) {
      print("in your card");
      await firebaseFirestore.collection("Cart").doc(id).update(ob.toJson());
      return;
    }
  }

  Future addToCart(Cart ob) async {
    final x = await firebaseFirestore
        .collection("Cart")
        .where("pid", isEqualTo: ob.pid)
        .get();
    final d = x.docs;
    if (d.length != 0) return;

    print("not in your card");

    await firebaseFirestore.collection("Cart").add(ob.toJson());
  }

  Stream getCart(String s) {
    return firebaseFirestore
        .collection("Cart")
        .where("uid", isEqualTo: s)
        .snapshots();
  }

  Stream getAllCart() {
    return firebaseFirestore.collection("Cart").snapshots();
  }

  Future deleteCart(Cart ob, BuildContext context) async {
    if (ob.isconfirm != null && ob.isconfirm != false) {
      showDialog(
          context: context,
          child: AlertDialog(
            content: Text("Your order is being prepared !"),
            actions: [
              custmoButton("ok", () {
                Navigator.of(context).pop();
              }, context, 100, 50)
            ],
          ));

      return;
    }

    await firebaseFirestore.collection("Cart").doc(ob.id).delete();
    print("delted");
  }

  Future confirmOrder(Cart ob, BuildContext context) async {
    if (ob.isconfirm != null) {
      print("order Confirmed and notification will be sent");
      Provider.of<NotificationProvider>(context, listen: false)
          .notificationData(ob);

      showDialog(
          context: context,
          child: AlertDialog(
            content: Text(
              "already confirmed!",
              style: textstyle5,
            ),
            actions: [
              custmoButton("ok", () {
                Navigator.of(context).pop();
              }, context, 100, 50)
            ],
          ));

      return;
    }

    showDialog(
        context: context,
        child: AlertDialog(
            content: Text(
              "if you press OK ,you cant delete it from your cart!",
              style: textstyle5,
            ),
            actions: [
              custmoButton("cancel", () {
                Navigator.of(context).pop();
              }, context, 100, 50),
              custmoButton("ok", () async {
                await firebaseFirestore
                    .collection("Cart")
                    .doc(ob.id)
                    .update({"isconfirm": true, "isdissmissed": false});

                Navigator.of(context).pop();
              }, context, 100, 50)
            ]));
  }
}
