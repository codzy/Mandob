import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/painting/image_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mandob/Screens/LoginPage.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() {
    return new _ForgetPasswordState();
  }
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String _email;
  final auth = FirebaseAuth.instance;

  void _showSentDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Sent'),
          content: Text(msg),
          actions: [
            FlatButton(
              child: Text('okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
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
              ? AssetImage('lib/Images/Customer2.png')
              : FileImage(_imageFile),
          fit: BoxFit.cover,
        )),
        height: double.infinity,
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 120,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reset Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'opensans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  helperStyle:
                                      TextStyle(color: Colors.grey[300])),
                              onChanged: (value) {
                                setState(() {
                                  _email = value.toString();
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: () {
                          auth.sendPasswordResetEmail(email: _email);
                          var sentMessage = 'Mail Sent. Please Check it.';
                          _showSentDialog(sentMessage);
                        },
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.white,
                        child: Text('Submit',
                            style: TextStyle(
                                color: Colors.green,
                                letterSpacing: 1.5,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'opensans')),
                      ),
                    ),
                    SizedBox(height: 70),
                    Container(
                      child: Text(
                        'We Will Mail You a Link ... Please Click on That Link to Reset Your Password',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontFamily: 'opensans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }),
                      );
                    },
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Done?    ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400)),
                        TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
