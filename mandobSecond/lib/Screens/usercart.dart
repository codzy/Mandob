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
import 'package:mandob/provider/productprovider.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/provider/workinhandprovider.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:provider/provider.dart';
import 'finishingscreendetails.dart';
import 'UserNotification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';

final imgurl =
    "https://image.freepik.com/free-photo/paperboard-texture_95678-72.jpg";

class UserCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(
        Provider.of<UserProvider>(context, listen: false).userprofile.toJson());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Cart',
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
                      "lib/Images/Ghost.gif",
                    ),
                    Text("Wo! No items Here")
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

                if (c.type == "product") {
                  wi = Product(
                      pic: c.ob["pic"],
                      price: c.ob["price"],
                      name: c.ob["name"],
                      dtime: c.ob["dtime"],
                      whprice: c.ob["whprice"],
                      desc: c.ob["desc"],
                      uid: c.ob["uid"]);

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          //  width: MediaQuery.of(context).size.width*.9,

                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Text(
                                  wi.name,
                                  style: textstyle6,
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
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
                                //
                              ),
                              Container(
                                // width: MediaQuery.of(context).size.width*.,
                                width: double.infinity,
                                height: 140,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 16,
                                        left: 5,
                                        child: Image.network(
                                          getAv(wi.pic),
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        )),
                                    Positioned(
                                      top: 15,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Name: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            wi.name,
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 34,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Unit Price: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            wi.price.toString(),
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 52,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "wholesale price: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            wi.whprice.toString(),
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 70,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Delivery Time: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            "${wi.dtime.toString()} Days",
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 89,
                                      left: 5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "you orderd: ${c.amount} Unit",
                                            style: textstyle5,
                                          ),
                                          Positioned(
                                            top: 89,
                                            left: 1,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Total: ",
                                                  style: textstyle5,
                                                ),
                                                Text(
                                                  "${c.amount * wi.whprice} Egp ",
                                                  style: textstyle6,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 5,
                                      child: Column(
                                        children: [
                                          custmoButton("Details", () async {
                                            await Provider.of<CartProvider>(
                                                    context,
                                                    listen: false)
                                                .goToEdit(c);

                                            await Provider.of<ProductProvider>(
                                                    context,
                                                    listen: false)
                                                .gotToEdit(wi);
                                            final route = MaterialPageRoute(
                                                builder: (context) {
                                              return ProductScreendetails();
                                            });
                                            Navigator.push(context, route);
                                          }, context, 80, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          custmoButton("delete", () async {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .deleteCart(c, context);
                                          }, context, 80, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            child: custmoButton("confirm",
                                                () async {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .confirmOrder(c, context);
                                            }, context, 100, 30),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )));
                }
////////////////////////////////////////////places
                else if (c.type == "place") {
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

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          //  width: MediaQuery.of(context).size.width*.9,

                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Text(
                                  wi.location,
                                  style: textstyle6,
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
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
                              Container(
                                // width: MediaQuery.of(context).size.width*.,
                                width: double.infinity,
                                height: 100,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 15,
                                        left: 5,
                                        child: Image.network(
                                          getAv(wi.pic),
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        )),
                                    Positioned(
                                      top: 10,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Location: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            wi.location,
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 30,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Size: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            wi.size.toString(),
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Rent price: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            wi.rprice.toString(),
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 70,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Sell price: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            wi.sprice.toString(),
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 1,
                                      child: Column(
                                        children: [
                                          custmoButton("Details", () async {
                                            await Provider.of<CartProvider>(
                                                    context,
                                                    listen: false)
                                                .goToEdit(c);

                                            await Provider.of<PlacesProvider>(
                                                    context,
                                                    listen: false)
                                                .gotToEdit(wi);

                                            final route = MaterialPageRoute(
                                                builder: (context) {
                                              return PlaceScreendetails();
                                            });
                                            Navigator.push(context, route);
                                          }, context, 80, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          custmoButton("delete", () async {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .deleteCart(c, context);
                                          }, context, 80, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          custmoButton("confirm", () async {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .confirmOrder(c, context);
                                          }, context, 100, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )));
                } else if (c.type == "hardware") {
                  wi = Hardware(
                      uid: c.ob["uid"],
                      pic: c.ob["pic"],
                      price: c.ob["price"],
                      iprice: c.ob["iprice"],
                      category: c.ob["categorty"],
                      desc: c.ob["desc"],
                      itemname: c.ob["itemname"]);
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          //  width: MediaQuery.of(context).size.width*.9,

                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Text(
                                  wi.itemname,
                                  style: textstyle6,
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
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
                                //
                              ),
                              Container(
                                // width: MediaQuery.of(context).size.width*.,
                                width: double.infinity,
                                height: 140,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 15,
                                        left: 5,
                                        child: Image.network(
                                          getAv(wi.pic),
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        )),
                                    Positioned(
                                      top: 20,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Name: ",
                                            style: textstyle5,
                                          ),
                                          Text(wi.itemname, style: textstyle6)
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 43,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text("Unit Price: ",
                                              style: textstyle5),
                                          Text(wi.price.toString(),
                                              style: textstyle6)
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 65,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text("installation price: ",
                                              style: textstyle5),
                                          Text(wi.iprice.toString(),
                                              style: textstyle6)
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 89,
                                      left: 10,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "you orderd: ",
                                                style: textstyle5,
                                              ),
                                              Text(
                                                "${c.amount} items",
                                                style: textstyle6,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                " Total: ",
                                                style: textstyle5,
                                              ),
                                              Text(
                                                " ${c.amount * wi.iprice + c.amount * wi.price} Egp ",
                                                style: textstyle6,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 5,
                                      child: Column(
                                        children: [
                                          custmoButton("Details", () async {
                                            await Provider.of<CartProvider>(
                                                    context,
                                                    listen: false)
                                                .goToEdit(c);

                                            await Provider.of<HardwareProvider>(
                                                    context,
                                                    listen: false)
                                                .gotToEdit(wi);
                                            final route = MaterialPageRoute(
                                                builder: (context) {
                                              return HardwareScreendetails();
                                            });
                                            Navigator.push(context, route);
                                          }, context, 80, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          custmoButton("delete", () async {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .deleteCart(c, context);
                                          }, context, 80, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          custmoButton("confirm", () async {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .confirmOrder(c, context);
                                          }, context, 100, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )));
                } else if (c.type == "workhand") {
                  wi = WorkingHand(
                    uid: c.uid,
                    cv: c.ob["cv"],
                    pic: c.ob["cv"],
                    work: c.ob["work"],
                    salary: c.ob["salary"],
                  );

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          //  width: MediaQuery.of(context).size.width*.9,

                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Text(
                                  'Hired Working hand',
                                  style: textstyle6,
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
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
                                //
                              ),
                              Container(
                                // width: MediaQuery.of(context).size.width*.,
                                width: double.infinity,
                                height: 100,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 15,
                                        left: 5,
                                        child: Image.network(
                                          wi.pic ?? imgurl,
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        )),
                                    Positioned(
                                      top: 35,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Expected Salary: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            wi.salary.toString(),
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 55,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Work Field: ",
                                            style: textstyle5,
                                          ),
                                          (wi.work == null)
                                              ? Text("Global")
                                              : Text(
                                                  wi.work,
                                                  style: textstyle6,
                                                ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 5,
                                      child: Column(
                                        children: [
                                          custmoButton("Details", () async {
                                            await Provider.of<CartProvider>(
                                                    context,
                                                    listen: false)
                                                .goToEdit(c);

                                            await Provider.of<
                                                        WorkingHandProvider>(
                                                    context,
                                                    listen: false)
                                                .gotToEdit(wi);
                                            final route = MaterialPageRoute(
                                                builder: (context) {
                                              return WorkingHandDetails();
                                            });
                                            Navigator.push(context, route);
                                          }, context, 80, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          custmoButton("delete", () async {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .deleteCart(c, context);
                                          }, context, 80, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          custmoButton("confirm", () async {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .confirmOrder(c, context);
                                          }, context, 100, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )));
                } else if (c.type == "finishing") {
                  wi = Finishing(
                      category: c.ob["categorty"],
                      pic: c.ob["pic"],
                      desc: c.ob["desc"],
                      uid: c.uid,
                      price: c.ob["price"],
                      worktype: c.ob["worktype"]);
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          //  width: MediaQuery.of(context).size.width*.9,

                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Text(
                                  wi.worktype,
                                  style: textstyle6,
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
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
                                //
                              ),
                              Container(
                                // width: MediaQuery.of(context).size.width*.,
                                width: double.infinity,
                                height: 100,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 15,
                                        left: 5,
                                        child: Image.network(
                                          getAv(wi.pic),
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        )),
                                    Positioned(
                                      top: 10,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Finishing Type: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            wi.worktype,
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 30,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "price/meter: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            wi.price.toString(),
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Size: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            "${c.amount / wi.price}" + " meter",
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 68,
                                      left: 77,
                                      child: Row(
                                        children: [
                                          Text(
                                            "total: ",
                                            style: textstyle5,
                                          ),
                                          Text(
                                            c.amount.toString() + "Egp",
                                            style: textstyle6,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 5,
                                      child: Column(
                                        children: [
                                          custmoButton("Details", () async {
                                            await Provider.of<CartProvider>(
                                                    context,
                                                    listen: false)
                                                .goToEdit(c);
                                            await Provider.of<
                                                        FinishingProvider>(
                                                    context,
                                                    listen: false)
                                                .gotToEdit(wi);
                                            final route = MaterialPageRoute(
                                                builder: (context) {
                                              return FinishingScreendetails();
                                            });
                                            Navigator.push(context, route);
                                          }, context, 80, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          custmoButton("delete", () async {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .deleteCart(c, context);
                                          }, context, 80, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          custmoButton("confirm", () async {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .confirmOrder(c, context);
                                          }, context, 100, 30),
                                          SizedBox(
                                            height: 3,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )));
                }
              }).toList());
            }
          },
        ),
      ),
    );
  }
}

String getAv(List nn) {
  for (var n in nn) {
    if (n != null) {
      return n;
    }
  }

  return imgurl;
}
