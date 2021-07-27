import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mandob/Screens/LoginPage.dart';
import 'package:mandob/Screens/placescreendetails.dart';
import 'package:mandob/Screens/productscreen.dart';
import 'package:mandob/Screens/workinghand.dart';
import 'package:mandob/model/place.dart';
import 'package:mandob/model/product.dart';
import 'package:mandob/model/workinghand.dart';
import 'package:mandob/provider/placeprovider.dart';
import 'package:mandob/provider/uploaddata.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/provider/workinhandprovider.dart';
import 'package:mandob/widgets/customtextfield.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:provider/provider.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:mandob/Screens/placescreen.dart';
////

final imgurl =
    "https://image.freepik.com/free-photo/paperboard-texture_95678-72.jpg";

class PlaceScreenItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("hi from item ");
    final workh = Provider.of<PlacesProvider>(context);
    final userdata = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Places',
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
        constraints: BoxConstraints.expand(),
        //   decoration: BoxDecoration(
        //      image: DecorationImage(
        //          image: AssetImage("lib/Images/Mandobman.png"),
        //           fit: BoxFit.cover)),
        child: Column(
          children: [
            headerConten("Your uploaded places"),
            Expanded(
              child: Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [Colors.white, Colors.blue[600]],
                      begin: const FractionalOffset(0.0, 0.5),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamBuilder<QuerySnapshot>(
                  stream: workh.getItem(FirebaseAuth.instance.currentUser.uid),
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
                        child: Text(
                          "no items",
                          style: textstyle1,
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      return ListView(
                          children: snapshot.data.docs.map((e) {
                        final wi = Place.fromJson(e);
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                //  width: MediaQuery.of(context).size.width*.9,

                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        gradient: new LinearGradient(
                                          colors: [
                                            Colors.blue[500],
                                            Colors.blue[100]
                                          ],
                                          begin:
                                              const FractionalOffset(0.5, 0.0),
                                          end: const FractionalOffset(0.0, 0.5),
                                          stops: [0.0, 1.0],
                                        ),
                                      ),
                                      child: Text(
                                        wi.location,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
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
                                                  style: TextStyle(
                                                      color: Colors.blue[700],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  wi.location,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
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
                                                  style: TextStyle(
                                                      color: Colors.blue[700],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  "${wi.size.toString()} meter",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
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
                                                  style: TextStyle(
                                                      color: Colors.blue[700],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  "${wi.rprice.toString()} Egp",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
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
                                                  style: TextStyle(
                                                      color: Colors.blue[700],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  "${wi.sprice.toString()} Egp",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 5,
                                            child: Column(
                                              children: [
                                                custmoButton("Details",
                                                    () async {
                                                  await workh.gotToEdit(wi);

                                                  final route =
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return PlaceScreendetails();
                                                  });
                                                  Navigator.push(
                                                      context, route);
                                                }, context, 80, 30),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                custmoButton("Edit", () async {
                                                  await workh.gotToEdit(wi);

                                                  final route =
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return PlaceSceen();
                                                  });
                                                  Navigator.push(
                                                      context, route);
                                                }, context, 70, 30),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                custmoButton("Delete",
                                                    () async {
                                                  print("delete btn pressed");

                                                  await workh
                                                      .deletePlace(wi.id);
                                                  await Provider.of<UploadData>(
                                                          context,
                                                          listen: false)
                                                      .deleteImg(wi.pic[0]);
                                                  await Provider.of<UploadData>(
                                                          context,
                                                          listen: false)
                                                      .deleteImg(wi.pic[1]);
                                                  await Provider.of<UploadData>(
                                                          context,
                                                          listen: false)
                                                      .deleteImg(wi.pic[2]);
                                                  await Provider.of<UploadData>(
                                                          context,
                                                          listen: false)
                                                      .deleteImg(wi.pic[3]);
                                                  await Provider.of<UploadData>(
                                                          context,
                                                          listen: false)
                                                      .deleteImg(wi.pic[4]);

                                                  print("delted");
                                                }, context, 80, 30),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )));
                      }).toList());
                    }
                  },
                ),
              ),
            ),
          ],
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
