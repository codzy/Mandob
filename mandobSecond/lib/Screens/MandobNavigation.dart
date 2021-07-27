import 'package:flutter/material.dart';
import 'package:mandob/Screens/UserProducts.dart';
import 'package:mandob/Screens/UserWorkingHands.dart';
import 'package:mandob/model/workinghand.dart';
import 'package:provider/provider.dart';
import '../provider/userprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';
import '../widgets/mandoblogo_icons.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:textfield_search/textfield_search.dart';
import 'UserPLaces.dart';
import 'UserHardware.dart';
import 'UserFinishing.dart';

class MandobNavigation extends StatefulWidget {
  @override
  _MandobNavigationState createState() => _MandobNavigationState();
}

class _MandobNavigationState extends State<MandobNavigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _category = TextEditingController();

  List cat = ['cars', 'mobiles', 'clothes'];
  String categoryChoice;
  var _imageFile;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.

    _category.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _category.addListener(() {
      categoryChoice = _category.text;
      print("My value is ${categoryChoice} Now !");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Mandob Categories',
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
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              padding: EdgeInsets.all(5),
              child: headerConten(
                'Choose your interest ',
              ),
            ),
            Column(
              children: [
                RaisedButton(
                  child: Text(
                    'Places suppliers',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  color: Colors.green[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserPlaces()),
                    );
                  },
                ),
                RaisedButton(
                  child: Text(
                    'Finishing Work ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  color: Colors.green[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserFinishing()),
                    );
                  },
                ),
                RaisedButton(
                  child: Text(
                    'Hardware Supplier',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  color: Colors.green[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserHardware()),
                    );
                  },
                ),
                RaisedButton(
                  child: Text(
                    'Products suppliers',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  color: Colors.green[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProduct(categoryChoice)),
                    );
                  },
                ),
                RaisedButton(
                  child: Text(
                    'Working Hands',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  color: Colors.green[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserWorkingHands(categoryChoice)),
                    );
                  },
                ),
              ],
            ),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFieldSearch(
                          label: "required category",
                          controller: _category,
                          initialList: cat,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
