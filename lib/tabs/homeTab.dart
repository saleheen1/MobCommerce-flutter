import 'package:flutter/material.dart';
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
                padding: EdgeInsets.only(top: 125),
                children: snapshot.data.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 250,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "${document.data()['images'][0]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12)),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.black.withOpacity(0.5),
                                ],
                              )),
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${document.data()["name"]}" ??
                                        "Product Name",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    "\$${document.data()["price"]}" ?? "0",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        ActionBar(
          title: "Home",
        ),
      ],
    );
  }
}
