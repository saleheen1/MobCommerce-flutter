import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/actionBar.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ActionBar(
          title: "Searchgit",
        ),
        Center(
          child: Container(
            child: Text("Searchgit"),
          ),
        ),
      ],
    );
  }
}
