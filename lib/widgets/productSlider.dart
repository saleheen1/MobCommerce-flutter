import 'package:flutter/material.dart';

class ProductSlider extends StatefulWidget {
  final List imageList;

  const ProductSlider({Key key, this.imageList}) : super(key: key);
  @override
  _ProductSliderState createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  int _selectedSlide = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 250,
            width: double.infinity,
            // height: 200,
            child: PageView(
              onPageChanged: (num) {
                setState(() {
                  _selectedSlide = num;
                });
              },
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  Image.network(
                    "${widget.imageList[i]}",
                    fit: BoxFit.cover,
                  ),
              ],
            )),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.imageList.length; i++)
                AnimatedContainer(
                  duration: Duration(milliseconds: 450),
                  curve: Curves.easeOutCubic,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: _selectedSlide == i
                        ? Theme.of(context).accentColor
                        : Colors.white,
                  ),
                  width: _selectedSlide == i ? 15 : 6,
                  height: 7,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                )
            ],
          ),
        )
      ],
    );
  }
}
