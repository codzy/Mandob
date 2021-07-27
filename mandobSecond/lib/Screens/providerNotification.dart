import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mandob/model/cart.dart';
import 'package:mandob/model/finish.dart';
import 'package:mandob/model/hardware.dart';
import 'package:mandob/model/place.dart';
import 'package:mandob/model/product.dart';
import 'package:mandob/model/workinghand.dart';
import 'package:mandob/provider/cartprovider.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderNotification extends StatelessWidget {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final imgurl =
      "https://image.freepik.com/free-photo/paperboard-texture_95678-72.jpg";

  @override
  Widget build(BuildContext context) {
    var currentUserId = Provider.of<UserProvider>(context, listen: false)
        .userprofile
        .toJson()["uid"];
    var currentUserName = Provider.of<UserProvider>(context, listen: false)
        .userprofile
        .toJson()["name"];
    var currentUserPhone = Provider.of<UserProvider>(context, listen: false)
        .userprofile
        .toJson()["phone"];

    print("$currentUserId $currentUserName $currentUserPhone");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notifications',
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF3366FF),
                  const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.blue[200], Colors.white10],
              begin: const FractionalOffset(0.0, 0.5),
              end: const FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              Provider.of<CartProvider>(context, listen: false).getAllCart(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                'Something went wrong',
                style: textstyle1,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData && snapshot.data.docs.length <= 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/Images/bel2.gif",
                      height: 250,
                      width: 250,
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data.docs.map((e) {
                final x = e["ob"]; // List dynamic inside map e['obj']
                final c = Cart.fromJson(e); //object from cart
                final buyerName = c.user['name'];
                final buyerPhone = c.user['phone'];
                var wi; // new object of bought stuff

                print("Stuck in listview");
                if (c.type == "product" &&
                    c.isconfirm == true &&
                    (c.isProviderDismissed != true) &&
                    c.ob['uid'] == currentUserId) {
                  print("Wow Iam insdie");
                  wi = Product(
                      pic: c.ob["pic"],
                      price: c.ob["price"],
                      name: c.ob["name"],
                      dtime: c.ob["dtime"],
                      whprice: c.ob["whprice"],
                      desc: c.ob["desc"],
                      uid: c.ob["uid"]);

                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //  width: MediaQuery.of(context).size.width*.9,

                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[500].withOpacity(0.7),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("You have an order to prepare",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ],
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "$buyerName ordered ${c.amount} ${wi.name} with total ${c.amount * wi.price} EGP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text("Call $buyerName Now for Delivery",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue[900]))
                                  ])
                            ],
                          ),
                        )),
                    secondaryActions: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red[300].withOpacity(0.7),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            await firebaseFirestore
                                .collection("Cart")
                                .doc(c.id)
                                .update({
                              "isProviderDismissed": true,
                              "isconfirm": false
                            });
                            print("notification dismissed");
                          },
                        ),
                      ),
                      IconSlideAction(
                          caption: 'Call Now',
                          color: Colors.green[700],
                          icon: Icons.call,
                          onTap: () async {
                            {
                              if (await canLaunch('tel:$buyerPhone')) {
                                await launch('tel:$buyerPhone');
                              } else {
                                throw 'Could not launch $buyerPhone';
                              }
                            }
                          }),
                    ],
                  );
                } else if (c.type == "place" &&
                    c.isconfirm == true &&
                    (c.isProviderDismissed != true) &&
                    c.ob['uid'] == currentUserId) {
                  print("Wow Iam insdie");
                  wi = Place(
                      desc: c.ob["desc"],
                      pic: c.ob["pic"],
                      location: c.ob["location"],
                      locationfrommap: c.ob["locationfrommap"],
                      size: c.ob["size"],
                      uid: c.ob["uid"],
                      isrent: c.ob["isrent"],
                      sprice: c.ob["sprice"],
                      rprice: c.ob["rprice"]);

                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //  width: MediaQuery.of(context).size.width*.9,

                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[300].withOpacity(0.7),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("You have an order to prepare",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ],
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "$buyerName Wants place in ${wi.location} of size ${wi.size}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text("Call $buyerName Now for Contracting",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue[900]))
                                  ])
                            ],
                          ),
                        )),
                    secondaryActions: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red[300].withOpacity(0.7),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            await firebaseFirestore
                                .collection("Cart")
                                .doc(c.id)
                                .update({
                              "isProviderDismissed": true,
                              "isconfirm": false
                            });
                            print("notification dismissed");
                          },
                        ),
                      ),
                      IconSlideAction(
                          caption: 'Call Now',
                          color: Colors.green[700],
                          icon: Icons.call,
                          onTap: () async {
                            {
                              if (await canLaunch('tel:$buyerPhone')) {
                                await launch('tel:$buyerPhone');
                              } else {
                                throw 'Could not launch $buyerPhone';
                              }
                            }
                          }),
                    ],
                  );
                } else if (c.type == "hardware" &&
                    c.isconfirm == true &&
                    (c.isProviderDismissed != true) &&
                    c.ob['uid'] == currentUserId) {
                  print("Wow Iam insdie");
                  wi = Hardware(
                      uid: c.ob["uid"],
                      pic: c.ob["pic"],
                      price: c.ob["price"],
                      iprice: c.ob["iprice"],
                      category: c.ob["categorty"],
                      desc: c.ob["desc"],
                      itemname: c.ob["itemname"]);

                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //  width: MediaQuery.of(context).size.width*.9,

                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[300].withOpacity(0.7),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("You have an order to prepare",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ],
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "$buyerName ordered ${c.amount} of size ${wi.itemname}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text(
                                        "with total ${(c.amount * wi.price) + wi.iprice} EGP inculding installing",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text("Call $buyerName Now for Contracting",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue[900]))
                                  ])
                            ],
                          ),
                        )),
                    secondaryActions: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red[300].withOpacity(0.7),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            await firebaseFirestore
                                .collection("Cart")
                                .doc(c.id)
                                .update({
                              "isProviderDismissed": true,
                              "isconfirm": false
                            });
                            print("notification dismissed");
                          },
                        ),
                      ),
                      IconSlideAction(
                          caption: 'Call Now',
                          color: Colors.green[700],
                          icon: Icons.call,
                          onTap: () async {
                            {
                              if (await canLaunch('tel:$buyerPhone')) {
                                await launch('tel:$buyerPhone');
                              } else {
                                throw 'Could not launch $buyerPhone';
                              }
                            }
                          }),
                    ],
                  );
                } else if (c.type == "workhand" &&
                    c.isconfirm == true &&
                    (c.isProviderDismissed != true) &&
                    c.ob['uid'] == currentUserId) {
                  print("Wow Iam insdie");
                  wi = WorkingHand(
                    uid: c.uid,
                    cv: c.ob["cv"],
                    pic: c.ob["cv"],
                    work: c.ob["work"],
                    salary: c.ob["salary"],
                  );

                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //  width: MediaQuery.of(context).size.width*.9,

                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[300].withOpacity(0.7),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("You are Hired",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ],
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "$buyerName Hired you for ${wi.work} field",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text("Contact $buyerName for contract",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                  ])
                            ],
                          ),
                        )),
                    secondaryActions: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red[300].withOpacity(0.7),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            await firebaseFirestore
                                .collection("Cart")
                                .doc(c.id)
                                .update({
                              "isProviderDismissed": true,
                              "isconfirm": false
                            });
                            print("notification dismissed");
                          },
                        ),
                      ),
                      IconSlideAction(
                          caption: 'Call Now',
                          color: Colors.green[700],
                          icon: Icons.call,
                          onTap: () async {
                            {
                              if (await canLaunch('tel:$buyerPhone')) {
                                await launch('tel:$buyerPhone');
                              } else {
                                throw 'Could not launch $buyerPhone';
                              }
                            }
                          }),
                    ],
                  );
                } else if (c.type == "finishing" &&
                    c.isconfirm == true &&
                    (c.isProviderDismissed != true) &&
                    c.ob['uid'] == currentUserId) {
                  print("Wow Iam insdie");

                  wi = Finishing(
                      category: c.ob["categorty"],
                      pic: c.ob["pic"],
                      desc: c.ob["desc"],
                      uid: c.uid,
                      price: c.ob["price"],
                      worktype: c.ob["worktype"]);

                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //  width: MediaQuery.of(context).size.width*.9,

                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[300].withOpacity(0.7),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("You Have New Finishing Job",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ],
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "$buyerName ordered Finishing of ${wi.worktype} with total ${wi.price} EGP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text(
                                        "with total ${(c.amount * wi.price) + wi.iprice} EGP inculding installing",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text("Call $buyerName Now for Contracting",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue[900]))
                                  ])
                            ],
                          ),
                        )),
                    secondaryActions: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red[300].withOpacity(0.7),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            await firebaseFirestore
                                .collection("Cart")
                                .doc(c.id)
                                .update({
                              "isconfirm": false,
                              "isProviderDismissed": true,
                            });
                            print(
                              "notification dismissed",
                            );

                            print("notification dismissed");
                          },
                        ),
                      ),
                      IconSlideAction(
                          caption: 'Call Now',
                          color: Colors.green[700],
                          icon: Icons.call,
                          onTap: () async {
                            {
                              if (await canLaunch('tel:$buyerPhone')) {
                                await launch('tel:$buyerPhone');
                              } else {
                                throw 'Could not launch $buyerPhone';
                              }
                            }
                          }),
                    ],
                  );
                } else {
                  print("You cant see me hehe");
                  return SizedBox.shrink();
                }
              }).toList());
            }
          },
        ),
      ),
    );
  }
}
