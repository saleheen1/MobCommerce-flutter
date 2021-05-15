import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/actionBar.dart';
import 'package:mobile_seller/widgets/constants.dart';
import 'package:mobile_seller/widgets/productSlider.dart';

class SingleProduct extends StatelessWidget {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("Products");
  final productId;

  SingleProduct({Key key, this.productId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("$productId");
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          FutureBuilder(
            future: _productRef.doc(productId).get(),
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
          ActionBar()
        ],
      ),
    ));
  }
}
