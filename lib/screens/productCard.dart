import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_seller/screens/singleProduct.dart';
import 'package:mobile_seller/widgets/constants.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productId;
  const ProductCard(
      {Key key, this.imageUrl, this.title, this.price, this.productId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(SingleProduct(
          productId: productId,
          price: price,
        ));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withOpacity(0.01),
                  spreadRadius: 0,
                  blurRadius: 13,
                  offset: Offset(4, 4), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            width: double.infinity,
            height: 300,
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "$imageUrl",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Text(
                  "$title" ?? "Product Name",
                  style: TextStyle(
                      color: Constants.kPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "\$$price" ?? "0",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
