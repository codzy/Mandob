import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  double rprice;
  List<dynamic> pic;
  String desc;
  String id;
  double sprice;
  int size;
  String location;
  String locationfrommap;
  bool isrent;
    String uid;


  Place(
      {this.pic,
      this.sprice,
      this.rprice,
      this.location,
      this.isrent,
      this.locationfrommap,
      this.desc,
      this.size,this.uid});

  //adding values to class
  Place.fromJson(DocumentSnapshot json) {
    //fromJson : for constructing a new PLace instance from a map structure.
    // DocumentSnapshot contains data read from a document in your Firestore database
    sprice = json["sprice"];
    pic = json["pic"];
    rprice = json["rprice"];
    desc = json["desc"];
    location = json["location"];
    size = json["size"];
    locationfrommap = json["locationfrommap"];
    isrent = json["isrent"];
        uid=json["uid"];


    id = json.id;
  }

  //adding values to Firebase
  Map<String, dynamic> toJson() {
    //toJson which converts a User instance into a map.
    return {
      "sprice": sprice,
      "pic": pic,
      "rprice": rprice,
      "location": location,
      "locationfrommap": locationfrommap,
      "size": size,
      "desc": desc,
      "isrent": isrent,
            "uid":uid

    };
  }
}
