import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Hardware {
  int price;
  List<dynamic> pic;
  String desc;
  String id;
  String category;
  String itemname;
  int iprice;
  String uid;

  Hardware(
      {this.pic,
      this.price,
      this.category,
      this.desc,
      this.itemname,
      this.iprice,
      this.uid});
  Hardware.fromJson(DocumentSnapshot json) {
    price = json["price"];
    pic = json["pic"];
    desc = json["desc"];
    itemname = json["itemname"];
    id = json.id;
    iprice = json["iprice"];
    category = json["categorty"];
    uid = json["uid"];
  }
  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "pic": pic,
      "itemname": itemname,
      "categorty": category,
      "desc": desc,
      "iprice": iprice,
      "uid": uid
    };
  }
}
