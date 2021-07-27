import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    var _imageFile;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {},
          // {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context){
          //           return SignupPage();
          //         }),
          //   );
          // },
        ),
      ),
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
              vertical: 30,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Edit Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'opensans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                              hintText: "Name",
                              helperStyle: TextStyle(color: Colors.grey[300])),
                          // onChanged: (value){
                          //   setState(() {
                          //     _email = value.toString();
                          //     // _authData['email'] = value.toString();
                          //   });
                          // },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
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
                              hintText: "User Name",
                              helperStyle: TextStyle(color: Colors.grey[300])),
                          // onChanged: (value){
                          //   setState(() {
                          //     _email = value.toString();
                          //     // _authData['email'] = value.toString();
                          //   });
                          // },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
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
                              helperStyle: TextStyle(color: Colors.grey[300])),
                          // onChanged: (value){
                          //   setState(() {
                          //     _password = value.toString();
                          //     // _authData['email'] = value.toString();
                          //   });
                          // },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
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
                              helperStyle: TextStyle(color: Colors.grey[300])),
                          // onChanged: (value){
                          //   setState(() {
                          //     _email = value.toString();
                          //     // _authData['email'] = value.toString();
                          //   });
                          // },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
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
                              hintText: "Phone Number",
                              helperStyle: TextStyle(color: Colors.grey[300])),
                          // onChanged: (value){
                          //   setState(() {
                          //     _email = value.toString();
                          //     // _authData['email'] = value.toString();
                          //   });
                          // },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
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
                              hintText: "Who are You?",
                              helperStyle: TextStyle(color: Colors.grey[300])),
                          // onChanged: (value){
                          //   setState(() {
                          //     _email = value.toString();
                          //     // _authData['email'] = value.toString();
                          //   });
                          // },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  child: RaisedButton(
                    elevation: 5,
                    onPressed: () {},
                    // {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context){
                    //           return SignupPage();
                    //         }),
                    //   );
                    // },
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
                SizedBox(height: 20),
                Container(
                  child: RaisedButton(
                    elevation: 5,
                    onPressed: () {},
                    // {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context){
                    //           return SignupPage();
                    //         }),
                    //   );
                    // },
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.white,
                    child: Text('Cancel',
                        style: TextStyle(
                            color: Colors.green,
                            letterSpacing: 1.5,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'opensans')),
                  ),
                ),
              ]),
            ]),
          )),
    );
  }
}
