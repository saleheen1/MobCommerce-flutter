import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_seller/services/firebaseServices.dart';
import 'package:mobile_seller/widgets/actionBar.dart';
import 'package:mobile_seller/widgets/constants.dart';
import 'package:mobile_seller/widgets/productSlider.dart';

class SingleProduct extends StatefulWidget {
  final productId;

  SingleProduct({Key key, this.productId}) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  int _selectedSize = 0;
  var _selectedProductSize = "M";

  FirebaseServices _firebaseServices = FirebaseServices();

  Future _addToCart() {
    //inserting data
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  void _formErrorToast(String message, Color _color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: _color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();
                List imageList = documentData['images'];
                List productSize = documentData['size'];
                return ListView(
                  padding: EdgeInsets.only(top: 81),
                  children: [
                    ProductSlider(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${documentData['name']}",
                                style: Constants.bigHeading,
                              ),
                              Text(
                                "\$${documentData['price']}",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${documentData['desc']}",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff8F8F8F),
                                fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          //Product size
                          Row(
                            children: [
                              for (var i = 0; i < productSize.length; i++)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedSize = i;
                                      _selectedProductSize = productSize[i];
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 19),
                                    alignment: Alignment.center,
                                    height: 45,
                                    width: 45,
                                    color: _selectedSize == i
                                        ? Theme.of(context).accentColor
                                        : Color(0xffDCDCDC),
                                    child: Text(
                                      "${productSize[i]}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: _selectedSize == i
                                              ? Colors.white
                                              : Constants.kPrimary),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          //Add to favorite or cart
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
          ActionBar(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(14),
                      margin: EdgeInsets.only(right: 10),
                      color: Color(0xffdcdcdc),
                      child: Icon(Icons.bookmark_outline)),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        await _addToCart();
                        _formErrorToast("Product added to cart", Colors.green);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        color: Constants.kPrimary,
                        child: Text(
                          "Add to cart",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
