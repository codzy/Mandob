import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
//import 'package:flutter/src/painting/image_provider.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mandob/Screens/ForgetPassword.dart';
import 'package:mandob/Screens/HomeScreen.dart';
import 'package:mandob/Screens/SliderPage.dart';
import 'dart:async';
import 'EditProfile.dart';
import 'SignupPage.dart';
import 'package:flutter_session/flutter_session.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _email , _password;
  final auth =FirebaseAuth.instance;

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Error'),
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



  Future<void> _Login() async {

    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.push(context, MaterialPageRoute(builder: (context){return SliderPage();}),);
      await FlutterSession().set("token", _email);
    }

   on FirebaseAuthException catch (error) {

      var errorMessage = 'Login Failed. Please Try again Later.';
      _showErrorDialog(errorMessage);
    }

  }

  static final FacebookLogin facebookSignIn = new FacebookLogin();

  bool _isloggedin = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);


  _loginG() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isloggedin = true;
      });
    } catch (err) {
      print(err);
    }
  }

  Future<Null> _loginFB() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);


    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!

         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
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
              ? AssetImage('lib/Images/Mandobman2.png')
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
                  'Sign In',
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
                                  hintText: "email",
                                  helperStyle:
                                      TextStyle(color: Colors.grey[300])),
                              onChanged: (value){
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
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "password",
                                  helperStyle:
                                      TextStyle(color: Colors.grey[300])),
                              onChanged: (value){
                                setState(() {
                                  _password = value.toString();
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () => {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context){
                        return ForgetPassword();
                        }),
                        )
                      },
                        child: Text('Forget password?',
                            style: TextStyle(color: Colors.green,
                            fontSize: 18
                            )),
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: _Login,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.white,
                        child: Text('LOGIN',
                            style: TextStyle(
                                color: Colors.green,
                                letterSpacing: 1.5,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'opensans')),
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Text(
                          'ــــــــــ or connect with ــــــــــ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: _loginFB,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                      blurRadius: 6,
                                    )
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://icons-for-free.com/iconfiles/png/512/facebook+logo+logo+website+icon-1320190502625926346.png")
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: _loginG,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                      blurRadius: 6,
                                    )
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://icon-library.com/images/icon-google/icon-google-22.jpg"))),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context){
                                  return SignupPage();
                                }),
                          );
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Don\'t have account?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
