import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mandob/Screens/hardwarescreendetails.dart';
import 'package:mandob/Screens/placescreendetails.dart';
import 'package:mandob/Screens/productscreendetails.dart';
import 'package:mandob/Screens/workhanddetails.dart';
import 'package:mandob/model/cart.dart';
import 'package:mandob/model/finish.dart';
import 'package:mandob/model/hardware.dart';
import 'package:mandob/model/place.dart';
import 'package:mandob/model/product.dart';
import 'package:mandob/model/workinghand.dart';
import 'package:mandob/provider/cartprovider.dart';
import 'package:mandob/provider/finishingprovider.dart';
import 'package:mandob/provider/hardwareprovider.dart';
import 'package:mandob/provider/placeprovider.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/provider/workinhandprovider.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:provider/provider.dart';
import 'finishingscreendetails.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserNotificaiton extends StatelessWidget {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final imgurl =
      "https://image.freepik.com/free-photo/paperboard-texture_95678-72.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Notifications',
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
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                final route = MaterialPageRoute(builder: (context) {
                  return LoginPage();
                });
                Navigator.pushReplacement(context, route);
              },
              child: Container(
                color: Colors.blue,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "logout",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF3366FF),
                const Color(0xFF00CCFF),
              ],
              begin: const FractionalOffset(0.1, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: Provider.of<CartProvider>(context, listen: false).getCart(
              Provider.of<UserProvider>(context, listen: false)
                  .userprofile
                  .toJson()["uid"]),
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
                var wi; // new object of bought stuff

                if (c.type == "product" &&
                    c.isconfirm == true &&
                    c.isdissmissed == false) {
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
                                  Text("Your order is being prepared",
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
                                        "You ordered ${c.amount} ${wi.name} with total ${c.amount * wi.price} EGP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text(
                                        "Expected Delivery Time : ${wi.dtime} Days",
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
                                .update({"isdissmissed": true});
                            print("notification dismissed");
                          },
                        ),
                      ),
                    ],
                  );
                }
////////////////////////////////////////////places
                else if (c.type == "place" &&
                    c.isconfirm == true &&
                    c.isdissmissed == false) {
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
                                  Text("Place Reserved ",
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
                                        "Your Place in ${wi.location} is reserved.\n      provider will contact you",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text("Expected Contacting is 3 Days",
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
                                .update({"isdissmissed": true});
                            print("notification dismissed");
                          },
                        ),
                      ),
                    ],
                  );
                } else if (c.type == "hardware" &&
                    c.isconfirm == true &&
                    c.isdissmissed == false) {
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
                                  Text("Your order is being prepared ",
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
                                        "${c.amount} of ${wi.itemname} with total ${c.amount * wi.price} EGP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text(
                                        "Total installation Price : ${c.amount * wi.iprice} EGP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text("Expected installation time is 3 Days",
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
                                .update({"isdissmissed": true});
                            print("notification dismissed");
                          },
                        ),
                      ),
                    ],
                  );
                } else if (c.type == "workhand" &&
                    c.isconfirm == true &&
                    c.isdissmissed == false) {
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
                                  Text("Hire process is ongoing... ",
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
                                        "Hired person will contact you shortly",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text("Expected salary ${wi.salary}",
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
                                .update({"isdissmissed": true});
                            print("notification dismissed");
                          },
                        ),
                      ),
                    ],
                  );
                } else if (c.type == "finishing" &&
                    c.isconfirm == true &&
                    c.isdissmissed == false) {
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
                                  Text("Finishing work is ordered ",
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
                                        "Finishing of ${wi.worktype} with total ${wi.price} EGP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue)),
                                    Text(" provider will contact you",
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
                                .update({"isdissmissed": true});
                            print("notification dismissed");
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              }).toList());
            }
          },
        ),
      ),
    );
  }

  String getAv(List nn) {
    for (var n in nn) {
      if (n != null) {
        return n;
      }
    }

    return imgurl;
  }
}
