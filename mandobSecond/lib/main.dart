import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mandob/Screens/EditProfile.dart';
import 'package:mandob/provider/HomeScreenProvider.dart';
import 'package:mandob/provider/NotificationProvider.dart';
import 'package:mandob/provider/cartprovider.dart';
import 'package:mandob/provider/finishingprovider.dart';
import 'package:mandob/provider/hardwareprovider.dart';
import 'package:mandob/provider/productprovider.dart';
import 'package:mandob/provider/uploaddata.dart';
import 'package:mandob/provider/workinhandprovider.dart';
import 'Screens/SliderPage.dart';
import 'package:provider/provider.dart';
import 'provider/userprovider.dart';
import 'theme/style.dart';
import 'provider/placeprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'provider/NotificationProvider.dart';
import 'dart:io';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // dynamic token = FlutterSession().get("token");

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => WorkingHandProvider()),
        ChangeNotifierProvider(create: (context) => UploadData()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => PlacesProvider()),
        ChangeNotifierProvider(create: (context) => FinishingProvider()),
        ChangeNotifierProvider(create: (context) => HardwareProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themdata,
        home:
            // token != '' ? EditProfile() :
            // to make user always logod in after restart app
            HomePage(),
        // change Edit profile to new home page after doing it
        // and don't forget to add this line to logout to really logout this user ---> FlutterSession().set('token'),'');
      )));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliderPage();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
