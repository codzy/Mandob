import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mandob/Screens/ProductScreenItem.dart';
import 'package:mandob/Screens/finishingscreenitem.dart';
import 'package:mandob/Screens/finishingworkscreen.dart';
import 'package:mandob/Screens/hardwarescreenitem.dart';
import 'package:mandob/Screens/hradwarescree.dart';
import 'package:mandob/Screens/placescreenitem.dart';
import 'package:mandob/Screens/productscreen.dart';
import 'package:mandob/Screens/usercart.dart';
import 'package:mandob/Screens/workinghand.dart';
import 'package:mandob/Screens/workinghanditem.dart';
import 'package:mandob/model/user.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/widgets/mandoblogo_icons.dart';
import 'package:provider/provider.dart';
import 'package:mandob/Screens/placescreen.dart';
import 'MandobNavigation.dart';
import 'UserNotification.dart';
import 'HomeScreen.dart';
import '../Screens/providerNotification.dart';
import 'MandobStatistics.dart';

/// This is the stateful widget that the main application instantiates.
class AppNaigation extends StatefulWidget {
  @override
  State<AppNaigation> createState() => _AppNaigationState();
}

class _AppNaigationState extends State<AppNaigation> {
  int _userHomeNavigate = 2;
  int _selectedIndex = 1;
  Users users;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _list = <Widget>[
    Center(child: CircularProgressIndicator()),
    Center(child: CircularProgressIndicator()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTappedUser(int index) {
    setState(() {
      _userHomeNavigate = index;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () async {
      FirebaseAuth auth = FirebaseAuth.instance;
      users = await Provider.of<UserProvider>(context, listen: false)
          .getUserData(auth.currentUser.uid);
      List listItem = [
        "Broker", //0
        "Finishing Worker", //1
        "Hardware Supplier", //2
        "Goods Supplier", //3
        "Working Hand", //4
        "Regular User" //5
      ];

      if (users.jobtype == listItem[3]) {
        _list = [ProviderNotification(), ProductScreenItme(), ProductScreen()];
      } else if (users.jobtype == listItem[4]) {
        _list = [
          ProviderNotification(),
          WorkingHandItme(),
          WorkingHandScreen(),
        ];
      } else if (users.jobtype == listItem[2]) {
        _list = [
          ProviderNotification(),
          HardwareScreenItme(),
          HardwareSceen(),
        ];
      } else if (users.jobtype == listItem[0]) {
        _list = [ProviderNotification(), PlaceScreenItem(), PlaceSceen()];
      } else if (users.jobtype == listItem[1]) {
        _list = [
          ProviderNotification(),
          FinishingScreenItme(),
          FinishingSceen()
        ];
      } else if (users.jobtype == listItem[5]) {
        _userHomeNavigate = 2;
        _list = [
          UserNotificaiton(),
          UserCart(),
          UserHomePage(),
          MandobNavigation(),
          MandobStatistics(),
        ];
      }
      setState(() {
        users = users;
        _list = _list;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<UserProvider>(context, listen: false)
    //     .getUserData(FirebaseAuth.instance.currentUser.uid);
    print("called Hi");
    return Scaffold(
        body: users == null
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: _list.elementAt(
                    _list.length == 5 ? _userHomeNavigate : _selectedIndex),
              ),
        bottomNavigationBar: _list.length == 3
            ? ConvexAppBar(
                items: [
                    TabItem(icon: Icons.notifications, title: 'Notification'),
                    TabItem(icon: Icons.home, title: 'Home'),
                    TabItem(icon: Icons.add, title: 'Add'),
                  ],
                initialActiveIndex: 1, //optional, default as 0
                onTap: (int i) {
                  _onItemTapped(i);
                })
            : ConvexAppBar(
                curveSize: 0,
                items: [
                  TabItem(icon: Icons.notifications, title: 'Noti'),
                  TabItem(icon: Icons.shopping_cart, title: 'Cart'),
                  TabItem(icon: Icons.home, title: 'Home'),
                  TabItem(icon: Mandoblogo.mandoblogo, title: 'Mandob'),
                  TabItem(icon: Icons.pie_chart, title: 'Statistics'),
                ],
                initialActiveIndex: 2, //optional, default as 0
                onTap: (int i) {
                  _onItemTappedUser(i);
                }));
  }
}
