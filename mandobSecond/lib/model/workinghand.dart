import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mandob/Screens/workinghand.dart';

class WorkingHand {
  int salary;
  String pic;
  String cv;
  String work;
  String id;
  String uid;

  WorkingHand({this.cv, this.pic, this.salary, this.work,this.uid});
  WorkingHand.fromJson(DocumentSnapshot json) {
    salary = json["salary"];
    cv = json["cv"];
    work = json["work"];
    pic = json["pic"];
    id = json.id;
        uid=json["uid"];

  }
  Map<String, dynamic> toJson() {
    return {"salary": salary, "pic": pic, "cv": cv, "work": work  ,    "uid":uid
};
  }
}
