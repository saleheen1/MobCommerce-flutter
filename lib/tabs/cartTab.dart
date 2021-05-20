import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_seller/screens/singleProduct.dart';
import 'package:mobile_seller/services/firebaseServices.dart';
import 'package:mobile_seller/services/services.dart';
import 'package:mobile_seller/widgets/actionBar.dart';
import 'package:mobile_seller/widgets/constants.dart';

Services _services = Services();

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
            StreamBuilder<QuerySnapshot>(
              stream: _firebaseServices.userRef
                  .doc(_firebaseServices.getUserId())
                  .collection("Cart")
                  .snapshots(),
              builder: (context, snapshot) {
                int pPrice = 0;
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
                                  child: FutureBuilder(
                                    future: _firebaseServices.productRef
                                        .doc(document.id)
                                        .get(),
                                    builder: (context, productSnap) {
                                      if (productSnap.hasError) {
                                        return Center(
                                          child: Text(
                                              "Error: ${productSnap.error}"),
                                        );
                                      } else if (productSnap.connectionState ==
                                          ConnectionState.done) {
                                        Map _product = productSnap.data.data();
                                        pPrice = pPrice + _product['price'];
                                        Future.delayed(Duration.zero, () async {
                                          _services.productPrice.value = pPrice;
                                        });

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(9),
                                                      width: 90,
                                                      height: 90,
                                                      child: Image.network(
                                                        "${_product['images'][0]}",
                                                        fit: BoxFit.fitHeight,
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
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .black,
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
                                                                  fontSize:
                                                                      16.0,
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
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                  onTap: () {
                                                    _removeProduct(document.id);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Icon(
                                                      Icons.delete_outline,
                                                      size: 30,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    ),
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

                      StreamBuilder(
                        //quering everything from collection Cart-- to get it real time using snapshot() is needed
                        stream: _firebaseServices.userRef
                            .doc(_firebaseServices.getUserId())
                            .collection("Cart")
                            .snapshots(),
                        builder: (context, snapshot) {
                          int totalItems;
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            List _documents = snapshot.data.docs;
                            totalItems = _documents.length;
                          }
                          return Column(
                            children: [
                              Obx(
                                () => Text(
                                  totalItems != 0
                                      ? "\$${_services.productPrice.value}"
                                      : "\$${"0"}",
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Constants.kPrimary,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                "Total items: $totalItems" ?? "0",
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Theme.of(context).accentColor,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
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
