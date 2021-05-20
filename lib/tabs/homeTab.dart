import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_seller/screens/productCard.dart';
import 'package:mobile_seller/screens/singleProduct.dart';
import 'package:mobile_seller/widgets/actionBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<QuerySnapshot>(
          future: _productRef.get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                padding: EdgeInsets.only(top: 75),
                children: snapshot.data.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
        ActionBar(
          hasBackArrow: false,
        ),
      ],
    );
  }
}
