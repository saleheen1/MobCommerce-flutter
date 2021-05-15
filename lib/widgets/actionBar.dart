import 'package:flutter/material.dart';
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
      padding: EdgeInsets.only(top: 50, left: 25, right: 25, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasBackArrow)
            Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                color: Constants.kPrimary,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          title != null
              ? Text(
                  title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              : Container(
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
