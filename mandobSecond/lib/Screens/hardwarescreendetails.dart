import 'package:flutter/material.dart';
import 'package:mandob/model/cart.dart';
import 'package:mandob/provider/cartprovider.dart';
//import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:mandob/provider/hardwareprovider.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HardwareScreendetails extends StatelessWidget {
  int amount = 1;
  @override
  Widget build(BuildContext context) {
    final hardware = Provider.of<HardwareProvider>(context, listen: false);
    final ct = Provider.of<CartProvider>(context, listen: false);
    var lp = hardware.hardware.pic;

    var desc = hardware.hardware.desc;
    var price = hardware.hardware.price;
    var name = hardware.hardware.itemname;
    var iPrice = hardware.hardware.iprice;
    var cate = hardware.hardware.category;
    final o = hardware.hardware;
    var pid = hardware.hardware.id;
    var cart = ct.cart;
    final key = GlobalKey<ScaffoldState>();
    hardware.hardware = null;
    ct.cart = null;
    var a = lp.toList();
    return Scaffold(
      key: key,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Hardwares',
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
              begin: const FractionalOffset(0.0, 0.1),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          children: [
            //Slider
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
                            child: Image.network(
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
            //Slider

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
                              child: Text("Name: $name", style: textstyle4))))),
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
                  height: 100,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Text(desc, style: textstyle4),
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
                              child: Text("Unit Price: ${price}",
                                  style: textstyle4))))),
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
                              child: Text("Installation Price: ${iPrice}",
                                  style: textstyle4))))),
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
                              child: Text("Category: $cate",
                                  style: textstyle4))))),
            ),
            Provider.of<UserProvider>(context, listen: false)
                        .userprofile
                        .jobtype ==
                    "Regular User"
                ? Column(
                    children: [
                      Row(
                        children: [
                          Text(" Amount:", style: textstyle4),
                          ChangeNotifierProvider(create: (context) {
                            return AmountProvider();
                          }, child: Consumer<AmountProvider>(
                              builder: (context, p, w) {
                            print("inc");
                            amount = p.amount;
                            print(amount);
                            return Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      p.decrement();
                                    }),
                                Text(p.amount.toString()),
                                IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      p.increment();
                                    }),
                                Text(
                                    "    TP:${amount * price} Eg ,IP:${amount * iPrice}Eg",
                                    style: textstyle4)
                              ],
                            );
                          })),
                        ],
                      ),
                      custmoButton(cart != null ? "Edit" : "Buy", () async {
                        var x =
                            Provider.of<UserProvider>(context, listen: false)
                                .userprofile;

                        Cart ob = Cart(
                            pid: pid,
                            user: x.toJson(),
                            ob: o.toJson(),
                            amount: amount,
                            type: "hardware",
                            isdissmissed: false,
                            uid: Provider.of<UserProvider>(context,
                                    listen: false)
                                .userprofile
                                .toJson()["uid"]);

                        if (cart != null) {
                          await Provider.of<CartProvider>(context,
                                  listen: false)
                              .editCart(ob, cart.id);
                          key.currentState.showSnackBar(SnackBar(
                            content: Text("Done"),
                          ));

                          print("updated!!!!!!!");
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

class AmountProvider extends ChangeNotifier {
  int amount = 1;

  increment() {
    amount++;
    notifyListeners();
  }

  decrement() {
    if (amount > 1) amount--;
    notifyListeners();
  }
}
