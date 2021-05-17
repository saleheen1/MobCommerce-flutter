import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_seller/screens/productCard.dart';
import 'package:mobile_seller/services/firebaseServices.dart';
import 'package:mobile_seller/widgets/actionBar.dart';
import 'package:mobile_seller/widgets/constants.dart';
import 'package:mobile_seller/widgets/customInput.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: 20,
          ),

          _searchString == ""
              ? Container(
                  child: Center(),
                )
              : FutureBuilder<QuerySnapshot>(
                  future: _firebaseServices.productRef
                      .orderBy("search_string")
                      .startAt([_searchString]).endAt(
                          ["$_searchString\uf8ff"]).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Scaffold(
                        body: Center(
                          child: Text("Error: ${snapshot.error}"),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return ListView(
                        padding: EdgeInsets.only(top: 87),
                        children: snapshot.data.docs.map((document) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            child: ProductCard(
                              title: document.data()["name"],
                              imageUrl: document.data()["images"][0],
                              price: document.data()["price"].toString(),
                              productId: document.id,
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: CustomInput(
              hintText: "Search",
              onSubmitted: (value) {
                setState(() {
                  _searchString = value.toLowerCase();
                });
              },
            ),
          ),
          // Text(
          //   "Search Result:0",
          //   style: Constants.regularHeading,
          // )
        ],
      ),
    );
  }
}
