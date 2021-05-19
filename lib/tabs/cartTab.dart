import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_seller/screens/singleProduct.dart';
import 'package:mobile_seller/services/firebaseServices.dart';
import 'package:mobile_seller/widgets/actionBar.dart';
import 'package:mobile_seller/widgets/constants.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  void _removeProduct(productId) {
    _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(productId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.userRef
                  .doc(_firebaseServices.getUserId())
                  .collection("Cart")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.active) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(top: 87),
                          children: snapshot.data.docs.map((document) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(SingleProduct(
                                      productId: document.id,
                                    ));
                                  },
                                  child: StreamBuilder(
                                    stream: _firebaseServices.productRef
                                        .doc(document.id)
                                        .snapshots(),
                                    builder: (context, productSnap) {
                                      if (productSnap.hasError) {
                                        return Center(
                                          child: Text(
                                              "Error: ${productSnap.error}"),
                                        );
                                      } else if (productSnap.connectionState ==
                                          ConnectionState.done) {
                                        Map _product = productSnap.data.data();
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    height: 90,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.network(
                                                        "${_product['images'][0]}",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: 16.0,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${_product['name']}",
                                                          style: TextStyle(
                                                              fontSize: 18.0,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 4.0,
                                                          ),
                                                          child: Text(
                                                            "\$${_product['price']}",
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Size: ${document.data()['size']}",
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _removeProduct(document.id);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Icon(
                                                    Icons.delete_outline,
                                                    size: 30,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Center();
                                      }
                                    },
                                  )),
                            );
                          }).toList(),
                        ),
                      ),
                      // Text("$"),
                      // StreamBuilder(
                      //   stream: _firebaseServices.userRef
                      //       .doc(_firebaseServices.getUserId())
                      //       .collection("Cart")
                      //       .snapshots(),
                      //   builder: (context, priceSnap) {
                      //     if (priceSnap.hasError) {
                      //       return Center(
                      //         child: Text("${priceSnap.error}"),
                      //       );
                      //     } else if (priceSnap.connectionState ==
                      //         ConnectionState.active) {
                      //           return Text("Total item: $priceSnap.")
                      //     } else {
                      //       return Center();
                      //     }
                      //   },
                      // ),
                      Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                            "Total items: 3",
                            style: TextStyle(
                              color: Constants.kPrimary,
                              fontSize: 17,
                            ),
                          )),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          color: Constants.kPrimary,
                          child: Text(
                            "Proceed to checkout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            ActionBar(
              title: "Cart",
            ),
          ],
        ),
      ),
    );
  }
}
