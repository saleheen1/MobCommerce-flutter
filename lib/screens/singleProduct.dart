import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_seller/services/firebaseServices.dart';
import 'package:mobile_seller/widgets/actionBar.dart';
import 'package:mobile_seller/widgets/constants.dart';
import 'package:mobile_seller/widgets/productSlider.dart';

class SingleProduct extends StatefulWidget {
  final productId;
  final String price;

  SingleProduct({Key key, this.productId, this.price = "0"}) : super(key: key);

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
        .set({"size": _selectedProductSize, "price": widget.price});
  }

  Future _saveItem() {
    //inserting data
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("SavedItem")
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
                  padding: EdgeInsets.only(top: 65),
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
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600],
                                    fontSize: 23),
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
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: _selectedSize == i
                                          ? Theme.of(context).accentColor
                                          : Color(0xffEAEAEA),
                                    ),
                                    margin: EdgeInsets.only(right: 19),
                                    alignment: Alignment.center,
                                    height: 45,
                                    width: 45,
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
                  InkWell(
                    onTap: () async {
                      await _saveItem();
                      _formErrorToast("Product saved", Color(0xff65C916));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xffEAEAEA),
                        ),
                        padding: EdgeInsets.all(14),
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.bookmark_outline)),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        await _addToCart();
                        _formErrorToast(
                            "Product added to cart", Color(0xff65C916));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Theme.of(context).accentColor,
                        ),
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
