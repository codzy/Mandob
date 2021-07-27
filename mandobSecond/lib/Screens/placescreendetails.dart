import 'package:flutter/material.dart';
//import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:google_maps_place_picker/providers/place_provider.dart';
import 'package:mandob/model/cart.dart';
import 'package:mandob/provider/cartprovider.dart';
import 'package:mandob/provider/placeprovider.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PlaceScreendetails extends StatelessWidget {
  int amount = 1;
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();

    final place = Provider.of<PlacesProvider>(context, listen: false);
    final ct = Provider.of<CartProvider>(context, listen: false);
    var lp = place.place.pic;
    var lat = place.place.locationfrommap.split("/")[1];
    var lng = place.place.locationfrommap.split("/")[2];

    var desc = place.place.desc;
    var sp = place.place.sprice;
    var rp = place.place.rprice;
    var s = place.place.size;
    var isr = place.place.isrent;
    var pid = place.place.id;
    var cart = ct.cart;

    final o = place.place;

    List<Marker> x = [
      Marker(
          markerId: MarkerId("werw"),
          position: LatLng(double.parse(lat), double.parse(lng)),
          infoWindow: InfoWindow(
              title: place.place.locationfrommap + "/" + place.place.location))
    ];
    ct.cart = null;
    place.place = null;
    return Scaffold(
      key: key,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Places',
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
      body: SingleChildScrollView(
          child: Container(
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
        child: Column(
          children: [
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: lp.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: (i == null)
                                ? Container(
                                    margin: EdgeInsets.all(50),
                                    child: CircularProgressIndicator())
                                : Image.network(
                                    i,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              padding: EdgeInsets.all(15),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                child: GoogleMap(
                  markers: Set.of(x),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(lat), double.parse(lng)),
                      zoom: 3),
                  myLocationEnabled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Describtion:",
                    style: textstyle3,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Theme.of(context).backgroundColor,
                  ),
                  width: double.infinity,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Text(
                        desc,
                        style: textstyle4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Theme.of(context).backgroundColor,
                          child: Center(
                              child: Text(
                            "Sell Price :${sp}",
                            style: textstyle4,
                          ))))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Theme.of(context).backgroundColor,
                          child: Center(
                              child: Text(
                            "rent Price :${rp}",
                            style: textstyle4,
                          ))))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Theme.of(context).backgroundColor,
                          child: Center(
                              child: Text(
                            isr ? "For Rent" : "For Sell",
                            style: textstyle4,
                          ))))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Theme.of(context).backgroundColor,
                          child: Center(
                              child: Text(
                            "Size:$s",
                            style: textstyle4,
                          ))))),
            ),
            Provider.of<UserProvider>(context, listen: false)
                        .userprofile
                        .jobtype ==
                    "Regular User"
                ? Column(
                    children: [
                      custmoButton(cart != null ? "Edit" : "Buy", () async {
                        var x =
                            Provider.of<UserProvider>(context, listen: false)
                                .userprofile;

                        Cart ob = Cart(
                            pid: pid,
                            user: x.toJson(),
                            ob: o.toJson(),
                            amount: amount,
                            type: "place",
                            isdissmissed: false,
                            uid: Provider.of<UserProvider>(context,
                                    listen: false)
                                .userprofile
                                .toJson()["uid"]);
                        if (cart != null) {
                          await Provider.of<CartProvider>(context,
                                  listen: false)
                              .editCart(ob, cart.id);
                          print("updated!!!!!!!");
                          key.currentState.showSnackBar(SnackBar(
                            content: Text("Done"),
                          ));

                          return;
                        }

                        await Provider.of<CartProvider>(context, listen: false)
                            .addToCart(ob);
                        key.currentState.showSnackBar(SnackBar(
                          content: Text("Done"),
                        ));
                      }, context, null, null),
                    ],
                  )
                : Text(''),
            SizedBox(
              height: 30,
            )
          ],
        ),
      )),
    );
  }
}
