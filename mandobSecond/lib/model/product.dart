import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  int price;
  List<dynamic> pic;
  String desc;
  String id;
  String name;
  double whprice;
  int dtime;
  String uid;
  String cat;

  Product({
    this.name,
    this.pic,
    this.price,
    this.whprice,
    this.dtime,
    this.desc,
    this.uid,
    this.cat,
  });

  Product.fromJson(DocumentSnapshot json) {
    price = json["price"];
    pic = json["pic"];
    whprice = json["whprice"];
    name = json["name"];
    desc = json["desc"];
    dtime = json["dtime"];
    uid = json["uid"];
    cat = json["cat"];
    id = json.id;
  }
  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "pic": pic,
      "name": name,
      "whprice": whprice,
      "dtime": dtime,
      "desc": desc,
      "uid": uid,
      "cat": cat
    };
  }
}
