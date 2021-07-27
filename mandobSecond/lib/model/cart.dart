import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String id;
  dynamic ob;
  int amount = 1;
  dynamic user;
  String type;
  String uid;
  String pid;
  bool isconfirm = false;
  bool isdissmissed = false;
  bool isProviderDismissed = false;

  Cart({
    this.user,
    this.ob,
    this.amount,
    this.type,
    this.uid,
    this.isconfirm,
    this.isdissmissed,
    this.pid,
    this.isProviderDismissed,
  });

  Cart.fromJson(DocumentSnapshot json) {
    id = json.id;
    user = json["user"];
    ob = json["ob"];
    amount = json["amount"];
    type = json["type"];
    uid = json["uid"];
    isconfirm = json["isconfirm"];
    pid = json["pid"];
    isdissmissed = json["isdissmissed"];
    isProviderDismissed = json["isProviderDismissed"];
  }
  Map<String, dynamic> toJson() {
    return {
      "user": user,
      "ob": ob,
      "amount": amount,
      "type": type,
      "uid": uid,
      "isconfirm": isconfirm,
      "pid": pid,
      "isdissmissed": isdissmissed,
      "isProviderDismissed": isProviderDismissed,
    };
  }
}
