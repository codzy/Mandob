import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob/model/place.dart';
import 'package:mandob/provider/placeprovider.dart';
import 'package:mandob/provider/uploaddata.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:mandob/widgets/customtextfield.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

enum SingingCharacter { rent, sale }

class PlaceSceen extends StatefulWidget {
  @override
  _PlaceSceenState createState() => _PlaceSceenState();
}

class _PlaceSceenState extends State<PlaceSceen> {
  TextEditingController describtion = TextEditingController();

  TextEditingController sprice = TextEditingController();

  TextEditingController rprice = TextEditingController();
  TextEditingController size = TextEditingController();

  TextEditingController location = TextEditingController();
  TextEditingController locationfrommap = TextEditingController();

  // RadioButtonInputElement isrent = RadioButtonInputElement();
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

  SingingCharacter _character = SingingCharacter.rent;
  bool isedit = false;
  Place ob;

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<PlacesProvider>(context, listen: false);
    if (place.place != null && i == 0) {
      sprice.text = place.place.sprice.toString();
      rprice.text = place.place.rprice.toString();
      location.text = place.place.location.toString();

      describtion.text = place.place.desc;
      locationfrommap.text = place.place.locationfrommap;

      size.text = place.place.size.toString();
      img1 = place.place.pic[0];
      img2 = place.place.pic[1];
      img3 = place.place.pic[2];

      img4 = place.place.pic[3];
      img5 = place.place.pic[4];
      isedit = true;
      ob = place.place;
    }
    i++;
    place.place = null;
    // final workh1=Provider.of<WorkingHandProvider>(context);
    // final workh2=Provider.of<WorkingHandProvider>(context,listen: false);

    print("build working hand caled");
    print(_character);

    return Scaffold(
        key: skey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Upload your Places',
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
                headerConten("Add new Place"),
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
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('rent'),
                      leading: Radio<SingingCharacter>(
                        activeColor: Colors.green,
                        value: SingingCharacter.rent,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('sale'),
                      leading: Radio<SingingCharacter>(
                        activeColor: Colors.green,
                        value: SingingCharacter.sale,
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
                        "Location:",
                        style: textstyle3,
                        textAlign: TextAlign.left,
                      ),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: headercolor,
                              borderRadius: BorderRadius.circular(30)),
                          child: CustomeFormField(location, false, "required",
                              '', null, TextInputType.text, () {}))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "geo Location:",
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey:
                                    "AIzaSyC3FEo_7bksnMhiBfGiZ9ruvW7c3bxRf2Y", // Put YOUR OWN KEY here.
                                onPlacePicked: (result) {
                                  locationfrommap.text = result
                                          .formattedAddress +
                                      "/" +
                                      result.geometry.location.lat.toString() +
                                      "/" +
                                      result.geometry.location.lng.toString();

                                  Navigator.of(context).pop();

                                  setState(() {});
                                },
                                initialPosition: LatLng(31.434, 31.32),
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                        },
                        readOnly: true,
                        controller: locationfrommap,
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
                        "Size",
                        style: textstyle3,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: headercolor,
                              borderRadius: BorderRadius.circular(30)),
                          child: CustomeFormField(size, false, "required", '',
                              null, TextInputType.text, () {}))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rent Price",
                        style: textstyle3,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: headercolor,
                              borderRadius: BorderRadius.circular(30)),
                          child: CustomeFormField(rprice, false, "required", '',
                              null, TextInputType.text, () {}))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sell Price",
                        style: textstyle3,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: headercolor,
                              borderRadius: BorderRadius.circular(30)),
                          child: CustomeFormField(sprice, false, "required", '',
                              null, TextInputType.text, () {}))
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                custmoButton(!isedit ? "Confirm" : "edit", () async {
                  print(rprice.text);
                  final lstimg = [img1, img2, img3, img4, img5];

                  final p = Place(
                      uid: FirebaseAuth.instance.currentUser.uid,
                      desc: describtion.text,
                      pic: lstimg,
                      rprice: double.parse(rprice.text),
                      sprice: double.parse(sprice.text),
                      location: location.text,
                      locationfrommap: locationfrommap.text,
                      isrent:
                          _character == SingingCharacter.rent ? true : false,
                      size: int.parse(size.text));
                  if (!isedit)
                    Provider.of<PlacesProvider>(context, listen: false)
                        .addPlace(p);
                  else {
                    Provider.of<PlacesProvider>(context, listen: false)
                        .editPlace(ob.id, p);
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
