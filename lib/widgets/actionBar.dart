import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_seller/services/firebaseServices.dart';
import 'package:mobile_seller/tabs/cartTab.dart';
import 'package:mobile_seller/widgets/constants.dart';

class ActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool showCart;

  ActionBar(
      {Key key, this.title, this.hasBackArrow = true, this.showCart = true})
      : super(key: key);
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("Users");

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 15, left: 25, right: 25, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasBackArrow)
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 30,
                  // color: Constants.kPrimary,
                  child: Icon(
                    Icons.arrow_back,
                    color: Constants.kPrimary,
                    size: 25,
                  )),
            ),
          title != null
              ? Text(
                  title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              : Container(
                  color: Colors.transparent,
                  height: 0,
                  width: 0,
                  child: Center(),
                ),
          showCart == true
              ? InkWell(
                  onTap: () {
                    Get.to(() => CartPage());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    // color: Constants.kPrimary,
                    child: StreamBuilder(
                      //quering everything from collection Cart-- to get it real time using snapshot() is needed
                      stream: _userRef
                          .doc(_firebaseServices.getUserId())
                          .collection("Cart")
                          .snapshots(),
                      builder: (context, snapshot) {
                        int totalItems = 0;
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          List _documents = snapshot.data.docs;
                          totalItems = _documents.length;
                        }
                        return Stack(
                          children: [
                            Icon(Icons.shopping_cart_outlined,
                                size: 30, color: Constants.kPrimary),
                            // Text(
                            //   "$totalItems" ?? "0",
                            //   style: TextStyle(color: Colors.white),
                            // ),
                            Positioned(
                              right: 0,
                              top: 2,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                )
              : Container(
                  height: 20,
                  width: 20,
                ),
        ],
      ),
    );
  }
}
