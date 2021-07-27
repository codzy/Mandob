 
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mandob/Screens/HomeScreen.dart';
import 'package:mandob/Screens/ProductScreenItem.dart';
import 'package:mandob/Screens/appnavigation.dart';
import 'package:mandob/Screens/productscreen.dart';
import 'package:mandob/Screens/workinghand.dart';
import 'package:mandob/Screens/workinghanditem.dart';
import 'package:mandob/model/user.dart';
import 'package:provider/provider.dart';
import 'package:slider_button/slider_button.dart';
import "package:firebase_auth/firebase_auth.dart";

import 'LoginPage.dart';
import 'package:mandob/provider/userprovider.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() {
    return new _SliderPageState();
  }
}

class _SliderPageState extends State<SliderPage> {
 // bool islogin;
  @override
  void initState() {
Future.delayed(Duration(seconds: 1),()async{
  FirebaseAuth auth=FirebaseAuth.instance;
  if(auth.currentUser!=null){


   final route=MaterialPageRoute(builder: (context){
     return AppNaigation();
   });
   Navigator.pushReplacement(context, route);
 
  }

  });








    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var _imageFile;
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _imageFile == null
                  ? AssetImage('lib/Images/Mandobman.png')
                  : FileImage(_imageFile),
              fit: BoxFit.cover,
            )
          ),
            alignment: Alignment.bottomCenter,
            child: SliderButton(
          action: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return LoginPage();
                // return  MultiProvider(
                //     providers: [
                //       ChangeNotifierProvider.value(value: Authentication(),
                //       )
                //     ],
                //     child: Builder(
                //       builder: (context) =>LoginPage(),
                //     )
                // );
              }),
            );
          },
          label: Text(
            "Slide to Start Page !",
            style: TextStyle(
                color: Color(0xEAE6E6FF),
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          icon: Center(
              child: Icon(
            Icons.arrow_forward,
            color: Colors.black,
            size: 35.0,
            semanticLabel: 'Text to announce in accessibility modes',
          )),
          width: 250,
          radius: 15,
          buttonColor: Color(0xECE8E8FF),
          backgroundColor: Color(0xff080809),
          highlightedColor: Colors.white,
          baseColor: Colors.red,

        )));
  }
}
