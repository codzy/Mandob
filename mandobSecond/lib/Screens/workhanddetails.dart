import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mandob/model/cart.dart';
import 'package:mandob/provider/cartprovider.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/provider/workinhandprovider.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';

class WorkingHandDetails extends StatelessWidget {
  final imgurl =
      "https://image.freepik.com/free-photo/paperboard-texture_95678-72.jpg";

  @override
  Widget build(BuildContext context) {
    final workh = Provider.of<WorkingHandProvider>(context, listen: false);
    final ct = Provider.of<CartProvider>(context, listen: false);
    var cart = ct.cart;
    final key = GlobalKey<ScaffoldState>();

    var pic = workh.workingHand.pic;
    var cv = workh.workingHand.cv;
    var sa = workh.workingHand.salary;
    var wo = workh.workingHand.work;
    final o = workh.workingHand;
    var pid = workh.workingHand.id;
    workh.workingHand = null;
    ct.cart = null;

    return Scaffold(
      key: key,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Working Hand',
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
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(pic ?? imgurl),
                  radius: 70,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Working C.V",
                      style: textstyle3,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  child: Container(
                    child: Image.network(
                      cv ?? imgurl,
                      fit: BoxFit.fill,
                    ),
                    width: double.infinity,
                    height: 220,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: double.infinity,
                            height: 50,
                            color: Theme.of(context).backgroundColor,
                            child: Center(
                                child: Text(
                              "Work Type:  ${wo}",
                              style: textstyle4,
                            ))))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: double.infinity,
                            height: 50,
                            color: Theme.of(context).backgroundColor,
                            child: Center(
                                child: Text(
                              "Salary: ${sa} Egp",
                              style: textstyle4,
                            ))))),
              ),
              Provider.of<UserProvider>(context, listen: false)
                          .userprofile
                          .jobtype ==
                      "Regular User"
                  ? Column(
                      children: [
                        custmoButton("Hire", () async {
                          var x =
                              Provider.of<UserProvider>(context, listen: false)
                                  .userprofile;

                          Cart ob = Cart(
                              pid: pid,
                              user: x.toJson(),
                              ob: o.toJson(),
                              amount: 1,
                              type: "workhand",
                              isdissmissed: false,
                              uid: Provider.of<UserProvider>(context,
                                      listen: false)
                                  .userprofile
                                  .toJson()["uid"]);

                          if (cart != null) {
                            await Provider.of<CartProvider>(context,
                                    listen: false)
                                .editCart(ob, cart.id);
                            print("updated!!!!!!!");
                            key.currentState.showSnackBar(SnackBar(
                              content: Text("Done"),
                            ));

                            return;
                          }
                          await Provider.of<CartProvider>(context,
                                  listen: false)
                              .addToCart(ob);
                          key.currentState.showSnackBar(SnackBar(
                            content: Text("Done"),
                          ));
                        }, context, null, null),
                      ],
                    )
                  : Text(''),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
