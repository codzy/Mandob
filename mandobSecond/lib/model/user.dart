import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Users {
  String id;
  String email;
  String phone;
  String name;
  String username;
  String jobtype;
  String uid;
  Users(
      {this.email,
      this.name,
      this.jobtype,
      this.phone,
      this.username,
      this.uid});

  Users.fromJson(DocumentSnapshot json) {
    id = json.id;
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    username = json["username"];
    jobtype = json["jobtype"];
    uid = json["uid"];
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "username": username,
      "jobtype": jobtype,
      "uid": uid
    };
  }
}
