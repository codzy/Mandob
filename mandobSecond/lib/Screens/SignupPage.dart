import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mandob/model/user.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:provider/provider.dart';
import 'LoginPage.dart';

class SignupPage extends StatefulWidget {
  final FirebaseApp app;
  SignupPage({this.app});

  @override
  _SignupPageState createState() {
    return new _SignupPageState();
  }
}

class _SignupPageState extends State<SignupPage> {
  final referenceData = FirebaseDatabase.instance;
  String _email, _password;
  var valueChoose;

  List listItem = [
    "Broker",
    "Finishing Worker",
    "Hardware Supplier",
    "Goods Supplier",
    "Working Hand",
    "Regular User",
  ];
  final auth = FirebaseAuth.instance;

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

  void _showDoneDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Done'),
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

  Map<String, String> _authData = {
    'name': '',
    'username': '',
    'password': '',
    'email': '',
    'phone_number': '',
    'identity': '',
  };

  Future<void> _SignUp() async {
    final ref = referenceData.reference();

    try {
      final user = await auth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) async {
        print("sucessful");

        await Provider.of<UserProvider>(context, listen: false).saveUserData(
            Users(
                uid: value.user.uid,
                jobtype: _authData["identity"],
                email: _authData["email"],
                name: _authData["name"],
                username: _authData["username"],
                phone: _authData["phone_number"]));
      });
      var doneMessage = 'Signup Success. you can Login now.';
      _showDoneDialog(doneMessage);
      // ref.child('Users').push().child('Name').set(_authData['name']).asStream();
      // ref
      //     .child('Users')
      //     .push()
      //     .child('username')
      //     .set(_authData['username'])
      //     .asStream();
      // ref
      //     .child('Users')
      //     .push()
      //     .child('password')
      //     .set(_authData['password'])
      //     .asStream();
      // ref
      //     .child('Users')
      //     .push()
      //     .child('email')
      //     .set(_authData['email'])
      //     .asStream();
      // ref
      //     .child('Users')
      //     .push()
      //     .child('phone_number')
      //     .set(_authData['phone_number'])
      //     .asStream();
      // ref
      //     .child('Users')
      //     .push()
      //     .child('identity')
      //     .set(_authData['identity'])
      //     .asStream();

    } on FirebaseAuthException catch (error) {
      print(error);
      var errorMessage = 'Signup Failed. Please Try again Later.';
      _showErrorDialog(errorMessage);
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
            child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Container(
              child: Center(
                child: Text("SIGNUP",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 5),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: "Name",
                  helperStyle: TextStyle(color: Colors.grey[300]),
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _authData['name'] = value.toString();
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 9, 40, 5),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: "Username",
                  helperStyle: TextStyle(color: Colors.grey[300]),
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _authData['username'] = value.toString();
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 9, 40, 5),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: "Password",
                  helperStyle: TextStyle(color: Colors.grey[300]),
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {
                  setState(() {
                    _password = value.toString();
                    _authData['password'] = value.toString();
                  });
                },
                obscureText: true,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 9, 40, 5),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: "Email",
                  helperStyle: TextStyle(color: Colors.grey[300]),
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    _email = value.toString();
                    _authData['email'] = value.trim();
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 9, 40, 5),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: "Phone Number",
                  helperStyle: TextStyle(color: Colors.grey[300]),
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _authData['phone_number'] = value.toString();
                  });
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1),
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              margin: EdgeInsets.fromLTRB(40, 9, 40, 10),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: DropdownButton(
                  hint: Center(child: Text("Who are you?")),
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 35,
                  value: valueChoose,
                  onChanged: (value) {
                    setState(() {
                      valueChoose = value.toString();
                      _authData['identity'] = value.toString();
                    });
                  },
                  items: listItem.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Center(child: Text(valueItem)),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(40, 9, 40, 5),
                alignment: Alignment.center,
                child: RaisedButton(
                  elevation: 5,
                  onPressed: _SignUp,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.white,
                  child: Text('SIGNUP',
                      style: TextStyle(
                          color: Colors.green,
                          letterSpacing: 1.5,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'opensans')),
                )),
            Container(
              margin: EdgeInsets.fromLTRB(40, 9, 40, 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Already have an account?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
                    TextSpan(
                        text: 'Login',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.w700))
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
