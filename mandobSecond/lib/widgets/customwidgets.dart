import 'package:flutter/material.dart';
import "package:mandob/theme/fonticon.dart";
import 'dart:io';

Container headerConten(String title) {
  return Container(
    decoration: new BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      gradient: new LinearGradient(
          colors: [Colors.blue[400], Colors.white10],
          begin: const FractionalOffset(0.5, 0.0),
          end: const FractionalOffset(0.0, 0.1),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    ),
    child: Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16, top: 15, bottom: 15),
      child: Stack(
        children: [
          Container(
            color: Color.fromRGBO(100, 200, 300, 500),
          ),
          Container(
            child: Center(
                child: Text(
              title,
              style: textstyle1,
            )),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.blue[300].withOpacity(0.7),

                spreadRadius: 5,

                blurRadius: 7,

                offset: Offset(0, 3), // changes position of shadow
              ),
            ], color: headertitle, borderRadius: BorderRadius.circular(20)),
            height: 35,
          ),
        ],
      ),
    ),
  );
}

Padding sizedBoxImg(String imgpath, double width, double height, File imgfile) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: width,
      height: height,
      child: Container(
        child: imgfile == null
            ? Image.network(imgpath, fit: BoxFit.fill)
            : Image.file(
                imgfile,
                fit: BoxFit.fill,
              ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );
}

Widget custmoButton(String txt, Function function, BuildContext context,
    double width, double heigt) {
  return SizedBox(
    height: heigt ?? 40,
    width: width ?? 100,
    child: RaisedButton(
      onPressed: function,
      child: Text(
        txt,
        style: textstyle2.copyWith(color: Colors.green),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
    ),
  );
}
