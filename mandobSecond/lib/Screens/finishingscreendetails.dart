import 'package:flutter/material.dart';
import 'package:mandob/model/cart.dart';
import 'package:mandob/provider/cartprovider.dart';
//import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:mandob/provider/finishingprovider.dart';
import 'package:mandob/provider/userprovider.dart';
import 'package:mandob/theme/fonticon.dart';
import 'package:mandob/widgets/customwidgets.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FinishingScreendetails extends StatelessWidget {
  int amount = 1;
  TextEditingController txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final c = Provider.of<CartProvider>(context, listen: false).cart;
    final finishing = Provider.of<FinishingProvider>(context, listen: false);
    final ct = Provider.of<CartProvider>(context, listen: false);
    var cart = ct.cart;
    var lp = finishing.finishing.pic;

    var desc = finishing.finishing.desc;
    var price = finishing.finishing.price;
    var cat = finishing.finishing.category;
    var worktype = finishing.finishing.worktype;
    final o = finishing.finishing;
    final key = GlobalKey<ScaffoldState>();
    var pid = finishing.finishing.id;
    finishing.finishing = null;
    ct.cart = null;
    print(price);

    return Scaffold(
      key: key,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Finishing Details',
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
                              child: Text("Finishing type :${worktype}",
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
                              child: Text("Price :${price}",
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
                          child: (cat == null)
                              ? Center(
                                  child: Text("category :${cat}",
                                      style: textstyle4))
                              : Center(
                                  child: Text("category : Global",
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
                          Text(" No of meters:"),
                          ChangeNotifierProvider(create: (context) {
                            return AmountProvider();
                          }, child: Consumer<AmountProvider>(
                              builder: (context, p, w) {
                            print("inc");
                            p.amount;
                            print(amount);

                            return Row(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 70,
                                  child: Container(
                                    color: Theme.of(context).backgroundColor,
                                    child: TextField(
                                      controller: txt,
                                      onChanged: (v) {
                                        print(v);
                                        amount = int.parse(v);

                                        p.increment();
                                      },
                                    ),
                                  ),
                                ),
                                Text("    TP:${amount * price} Eg")
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
                            amount: amount * price,
                            type: "finishing",
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
        )),
      ),
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
