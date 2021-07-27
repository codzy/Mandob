import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandob/model/finish.dart';
import 'package:mandob/model/hardware.dart';
import 'package:mandob/model/product.dart';
import '../model/cart.dart';

class NotificationProvider with ChangeNotifier {
  Cart cartData;

  void notificationData(Cart c) {
    cartData = c;
  }
}
