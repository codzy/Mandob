import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob/Screens/workinghanditem.dart';
import 'package:mandob/model/workinghand.dart';
import 'package:mandob/provider/uploaddata.dart';
import 'package:mandob/provider/workinhandprovider.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:mandob/widgets/customtextfield.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:provider/provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:textfield_search/textfield_search.dart';
import 'LoginPage.dart';

List cat = ["cars", "mobiles", "clothes"];

class WorkingHandScreen extends StatefulWidget {
  @override
  _WorkingHandScreenState createState() => _WorkingHandScreenState();
}

class _WorkingHandScreenState extends State<WorkingHandScreen> {
  TextEditingController category = TextEditingController();

  TextEditingController expetedSalary = TextEditingController();

  final imgurl =
      "https://image.freepik.com/free-photo/paperboard-texture_95678-72.jpg";

  var img1;

  var img2;

  final skey = GlobalKey<ScaffoldState>();

  int i = 0;
  bool isedit = false;
  WorkingHand ob;
//   @override
//   void dispose() {
// Provider.of<WorkingHandProvider>(context,listen: false).workingHand=null;
// category.dispose();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    category.text = cat[0];

    final workh = Provider.of<WorkingHandProvider>(context, listen: false);
    print(workh.workingHand ?? "null now");
    if (i == 0 && workh.workingHand != null) {
      print("caled");
      category.text = workh.workingHand.work;
      expetedSalary.text = workh.workingHand.salary.toString();
      isedit = true;
      ob = workh.workingHand;
      img1 = workh.workingHand.pic;
      img2 = workh.workingHand.cv;
    }
    i++;
    workh.workingHand = null;

    // final workh1=Provider.of<WorkingHandProvider>(context);
    // final workh2=Provider.of<WorkingHandProvider>(context,listen: false);

    print("build working hand caled");

    return Scaffold(
        key: skey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Upload Your Resumee',
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
                colors: [Colors.blue, Colors.blue[50]],
                begin: const FractionalOffset(0.0, 0.5),
                end: const FractionalOffset(0.5, 0.0),
                stops: [0.1, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                headerConten("Working Hand"),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Add Pic: ",
                  style: textstyle3,
                  textAlign: TextAlign.center,
                ),
                // ignore: missing_required_param
                ChangeNotifierProvider(
                  create: (context) {
                    return UploadData();
                  },
                  child: Consumer<UploadData>(builder: (context, w, r) {
                    return GestureDetector(
                      child: sizedBoxImg(img1 ?? imgurl, 70, 70, w.img),
                      onTap: () async {
                        await w.chooseImage(ImageSource.gallery);
                        img1 = await w.uploadFile();
                      },
                    );
                  }),
                ),
                Text(
                  "CV :",
                  style: textstyle3,
                  textAlign: TextAlign.center,
                ),
                ChangeNotifierProvider(
                  create: (context) {
                    return UploadData();
                  },
                  child: Consumer<UploadData>(builder: (context, w, r) {
                    return GestureDetector(
                      child: sizedBoxImg(
                          img2 ?? imgurl, double.infinity, 100, w.img),
                      onTap: () async {
                        await w.chooseImage(ImageSource.gallery);
                        img2 = await w.uploadFile();
                      },
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Category",
                        style: textstyle3,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: headercolor,
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFieldSearch(
                            label: "Working Area",
                            controller: category,
                            initialList: cat,
                          )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Expected Salary:",
                      style: textstyle3,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: headercolor,
                            borderRadius: BorderRadius.circular(30)),
                        child: CustomeFormField(expetedSalary, false,
                            "required", '', null, TextInputType.text, () {}))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),

                custmoButton(!isedit ? "Confirm" : "edit", () async {
                  final workingh = WorkingHand();
                  if (!isedit)
                    await Provider.of<WorkingHandProvider>(context,
                            listen: false)
                        .addHandWork(WorkingHand(
                            uid: FirebaseAuth.instance.currentUser.uid,
                            pic: img1,
                            cv: img2,
                            work: category.text,
                            salary: int.parse(expetedSalary.text)));
                  else {
                    await Provider.of<WorkingHandProvider>(context,
                            listen: false)
                        .editResumee(
                            ob.id,
                            WorkingHand(
                                pic: img1,
                                cv: img2,
                                work: category.text,
                                salary: int.parse(expetedSalary.text)));
                  }

                  skey.currentState.showSnackBar(
                      SnackBar(content: Text("data saved Successfully")));
                }, context, null, null),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ));
  }
}
