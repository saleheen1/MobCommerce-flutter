import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_seller/widgets/constants.dart';

class ActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;

  const ActionBar({Key key, this.title, this.hasBackArrow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 20),
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
                  height: 40,
                  width: 40,
                  color: Constants.kPrimary,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
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
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            color: Constants.kPrimary,
            child: Text(
              "0",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
