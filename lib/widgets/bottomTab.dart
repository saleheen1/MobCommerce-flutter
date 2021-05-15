import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/constants.dart';

class BottomTabBar extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;

  const BottomTabBar({Key key, this.selectedTab, this.tabPressed})
      : super(key: key);
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _selectedTab;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          spreadRadius: 1.0,
          blurRadius: 30,
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            icon: Icons.home_outlined,
            isSelected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabBtn(
            icon: Icons.search,
            isSelected: _selectedTab == 1 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressed(1);
              });
            },
          ),
          BottomTabBtn(
            icon: Icons.bookmark_outline,
            isSelected: _selectedTab == 2 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressed(2);
              });
            },
          ),
          BottomTabBtn(
            icon: Icons.ac_unit_outlined,
            isSelected: _selectedTab == 3 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressed(3);
              });
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final Function onPressed;

  const BottomTabBtn(
      {Key key, this.icon, this.isSelected = false, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: isSelected
                      ? Theme.of(context).accentColor
                      : Colors.transparent,
                  width: 3))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Icon(
              icon ?? Icons.home,
              size: 30,
              color: isSelected
                  ? Theme.of(context).accentColor
                  : Constants.kPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
