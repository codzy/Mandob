import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mandob/Screens/LoginPage.dart';
import 'package:mandob/Screens/ProductScreenItem.dart';
import 'package:mandob/Screens/workhanddetails.dart';
import 'package:mandob/model/workinghand.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:provider/provider.dart';
import 'package:mandob/theme/fonticon.dart';
import '../provider/workinhandprovider.dart';
import 'package:mandob/model/workinghand.dart';

final imgurl =
    "https://image.freepik.com/free-photo/paperboard-texture_95678-72.jpg";

class UserWorkingHands extends StatelessWidget {
  @override
  final c;
  UserWorkingHands(this.c);

  Widget build(BuildContext context) {
    print("User Places are Here ");

    final workh = Provider.of<WorkingHandProvider>(context);
    final userdata = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                  Text("logout")
                ],
              ),
            )
          ],
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
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
        child: Column(
          children: [
            headerConten("Working hands"),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: StreamBuilder<QuerySnapshot>(
                stream: workh.getUserItem(c),
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
                                      userdata.userprofile.name,
                                      style: textstyle6,
                                      textAlign: TextAlign.center,
                                    ),
                                    decoration: BoxDecoration(
                                        gradient: new LinearGradient(
                                            colors: [
                                              Colors.white,
                                              Colors.blue,
                                            ],
                                            begin: const FractionalOffset(
                                                0.0, 0.0),
                                            end: const FractionalOffset(
                                                1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                        color: Color(0xffA6D8FF),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
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
                                                "Preferible field: ",
                                                style: textstyle5,
                                              ),
                                              (wi.work != null)
                                                  ? Text(
                                                      wi.work,
                                                      style: textstyle6,
                                                    )
                                                  : Text(
                                                      "Global",
                                                      style: textstyle6,
                                                    )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          bottom: 35,
                                          child: Column(
                                            children: [
                                              custmoButton("Details", () async {
                                                await workh.gotToEdit(wi);
                                                final route = MaterialPageRoute(
                                                    builder: (context) {
                                                  return WorkingHandDetails();
                                                });
                                                Navigator.push(context, route);
                                              }, context, 80, 30),
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
                    }).toList());
                  }
                },
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
