import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob/model/finish.dart';
import 'package:mandob/provider/finishingprovider.dart';
import 'package:mandob/provider/placeprovider.dart';
import 'package:mandob/provider/uploaddata.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:mandob/widgets/customtextfield.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:provider/provider.dart';
import 'package:textfield_search/textfield_search.dart';

enum SingingCharacter { lux, superlux, ultralux }

List cat = ["cars", "mobiles", "clothes"];

class FinishingSceen extends StatefulWidget {
  @override
  _FinishingSceenState createState() => _FinishingSceenState();
}

class _FinishingSceenState extends State<FinishingSceen> {
  TextEditingController describtion = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController category = TextEditingController();

  TextEditingController worktype = TextEditingController();

  // RadioButtonInputElement islux = RadioButtonInputElement();
  var nn;
  final imgurl =
      "https://image.freepik.com/free-photo/paperboard-texture_95678-72.jpg";

  String img1;

  String img2;

  String img3;

  String img4;

  String img5;

  final skey = GlobalKey<ScaffoldState>();

  int i = 0;

  SingingCharacter _character = SingingCharacter.lux;
  bool isedit = false;
  Finishing ob;

  @override
  Widget build(BuildContext context) {
    final finishing = Provider.of<FinishingProvider>(context, listen: false);
    if (finishing.finishing != null && i == 0) {
      if (finishing.finishing.worktype == "lux") {
        _character = SingingCharacter.lux;
      } else if (finishing.finishing.worktype == "superlux") {
        _character = SingingCharacter.superlux;
      } else {
        _character = SingingCharacter.ultralux;
      }

      price.text = finishing.finishing.price.toString();
      category.text = finishing.finishing.category;

      describtion.text = finishing.finishing.desc;
      worktype.text = finishing.finishing.worktype;

      img1 = finishing.finishing.pic[0];
      img2 = finishing.finishing.pic[1];
      img3 = finishing.finishing.pic[2];

      img4 = finishing.finishing.pic[3];
      img5 = finishing.finishing.pic[4];
      isedit = true;
      ob = finishing.finishing;
    }
    i++;
    finishing.finishing = null;

    // final workh1=Provider.of<WorkingHandProvider>(context);
    // final workh2=Provider.of<WorkingHandProvider>(context,listen: false);

    print("build working hand caled");
    print(_character);

    return Scaffold(
        key: skey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Upload your finishing',
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
        body: Container(
          decoration: BoxDecoration(
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                headerConten("Add new finishing"),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Add Pic :",
                  style: textstyle3,
                  textAlign: TextAlign.center,
                ),
                // ignore: missing_required_param
                SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
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
                      ChangeNotifierProvider(
                        create: (context) {
                          return UploadData();
                        },
                        child: Consumer<UploadData>(builder: (context, w, r) {
                          return GestureDetector(
                            child: sizedBoxImg(img2 ?? imgurl, 70, 70, w.img),
                            onTap: () async {
                              await w.chooseImage(ImageSource.gallery);
                              img2 = await w.uploadFile();
                            },
                          );
                        }),
                      ),
                      ChangeNotifierProvider(
                        create: (context) {
                          return UploadData();
                        },
                        child: Consumer<UploadData>(builder: (context, w, r) {
                          return GestureDetector(
                            child: sizedBoxImg(img3 ?? imgurl, 70, 70, w.img),
                            onTap: () async {
                              await w.chooseImage(ImageSource.gallery);
                              img3 = await w.uploadFile();
                            },
                          );
                        }),
                      ),
                      ChangeNotifierProvider(
                        create: (context) {
                          return UploadData();
                        },
                        child: Consumer<UploadData>(builder: (context, w, r) {
                          return GestureDetector(
                            child: sizedBoxImg(img4 ?? imgurl, 70, 70, w.img),
                            onTap: () async {
                              await w.chooseImage(ImageSource.gallery);
                              img4 = await w.uploadFile();
                            },
                          );
                        }),
                      ),
                      ChangeNotifierProvider(
                        create: (context) {
                          return UploadData();
                        },
                        child: Consumer<UploadData>(builder: (context, w, r) {
                          return GestureDetector(
                            child: sizedBoxImg(img5 ?? imgurl, 70, 70, w.img),
                            onTap: () async {
                              await w.chooseImage(ImageSource.gallery);
                              img5 = await w.uploadFile();
                            },
                          );
                        }),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Describtion:",
                      style: textstyle3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Theme.of(context).backgroundColor,
                      child: TextFormField(
                        controller: describtion,
                        maxLines: 5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Price/meter:",
                        style: textstyle3,
                        textAlign: TextAlign.left,
                      ),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: headercolor,
                              borderRadius: BorderRadius.circular(30)),
                          child: CustomeFormField(price, false, "required", '',
                              null, TextInputType.text, () {}))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Finishing Type:",
                      style: textstyle3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('lux'),
                      leading: Radio<SingingCharacter>(
                        activeColor: Colors.green,
                        value: SingingCharacter.lux,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('superlux'),
                      leading: Radio<SingingCharacter>(
                        activeColor: Colors.green,
                        value: SingingCharacter.superlux,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('ultralux'),
                      leading: Radio<SingingCharacter>(
                        activeColor: Colors.green,
                        value: SingingCharacter.ultralux,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ],
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
                            label: category.text,
                            controller: category,
                            initialList: cat,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                custmoButton(!isedit ? "Confirm" : "edit", () async {
                  final lstimg = [img1, img2, img3, img4, img5];
                  final fh = Finishing(
                      uid: FirebaseAuth.instance.currentUser.uid,
                      desc: describtion.text,
                      pic: lstimg,
                      category: category.text,
                      worktype: _character.toString().split(".")[1],
                      price: int.parse(price.text));
                  if (!isedit)
                    await Provider.of<FinishingProvider>(context, listen: false)
                        .addFinishing(fh);
                  else {
                    await Provider.of<FinishingProvider>(context, listen: false)
                        .editFinishing(ob.id, fh);
                    finishing.finishing = null;
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
