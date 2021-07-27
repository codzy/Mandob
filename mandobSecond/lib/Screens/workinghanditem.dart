import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mandob/Screens/LoginPage.dart';
import 'package:mandob/Screens/workhanddetails.dart';
import 'package:mandob/Screens/workinghand.dart';
import 'package:mandob/model/workinghand.dart';
import 'package:mandob/provider/uploaddata.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/provider/workinhandprovider.dart';
import 'package:mandob/widgets/customtextfield.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:provider/provider.dart';
import 'package:mandob/theme/fonticon.dart';

final imgurl =
    "https://image.freepik.com/free-photo/paperboard-texture_95678-72.jpg";

class WorkingHandItme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("hi from item ");
    final workh = Provider.of<WorkingHandProvider>(context);
    final userdata = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your uploaded Resumee',
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
      body: Column(
        children: [
          headerConten("Your Resumee"),
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
                      final wi = WorkingHand.fromJson(e);
                      return Padding(
                          padding: const EdgeInsets.all(15.0),
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
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        "your Uploaded Cv",
                                        style: textstyle4,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        gradient: new LinearGradient(
                                            colors: [
                                              Colors.blue[500],
                                              Colors.blue[100]
                                            ],
                                            begin: const FractionalOffset(
                                                0.5, 0.0),
                                            end: const FractionalOffset(
                                                0.0, 0.5),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                        color: Color(0xffA6D8FF),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                  ),
                                  Container(
                                    // width: MediaQuery.of(context).size.width*.,
                                    width: double.infinity,
                                    height: 100,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top: 5,
                                            left: 5,
                                            child: Image.network(
                                              wi.pic ?? imgurl,
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
                                                "Name:  ",
                                                style: TextStyle(
                                                    color: Colors.blue[700],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                userdata.userprofile.name,
                                                style: textstyle4,
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 45,
                                          left: 77,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Salary:  ",
                                                style: TextStyle(
                                                    color: Colors.blue[700],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                wi.salary.toString(),
                                                style: textstyle4,
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          child: Column(
                                            children: [
                                              custmoButton("Details", () async {
                                                await workh.gotToEdit(wi);

                                                final route = MaterialPageRoute(
                                                    builder: (context) {
                                                  return WorkingHandDetails();
                                                });
                                                Navigator.push(context, route);
                                                //workh.dispose();
                                              }, context, 80, 30),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              custmoButton("Edit", () async {
                                                await workh.gotToEdit(wi);

                                                final route = MaterialPageRoute(
                                                    builder: (context) {
                                                  return WorkingHandScreen();
                                                });
                                                Navigator.push(context, route);
                                              }, context, 70, 30),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              custmoButton("Delete", () async {
                                                await workh
                                                    .deleteResumee(wi.id);
                                                await Provider.of<UploadData>(
                                                        context,
                                                        listen: false)
                                                    .deleteImg(wi.pic);
                                                await Provider.of<UploadData>(
                                                        context,
                                                        listen: false)
                                                    .deleteImg(wi.cv);

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
      // bottomNavigationBar:  ConvexAppBar(
      //       items: [
      //         TabItem(icon: Icons.notifications, title: 'Notificatio'),
      //         TabItem(icon: Icons.home, title: 'Home'),
      //         TabItem(icon: Icons.add, title: 'Add'),
      //       ],
      //       initialActiveIndex: 1, //optional, default as 0
      //       onTap: (int i) {
      //         var route;
      //         if (i == 2) {
      //           route = MaterialPageRoute(builder: (cotext) {
      //             return WorkingHandScreen();
      //           });
      //        Navigator.push(context, route);

      //         }
      //       }),
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
