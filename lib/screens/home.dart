import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_seller/tabs/cartTab.dart';
import 'package:mobile_seller/tabs/homeTab.dart';
import 'package:mobile_seller/tabs/profileTab.dart';
import 'package:mobile_seller/tabs/searchTab.dart';
import 'package:mobile_seller/widgets/bottomTab.dart';
import 'package:mobile_seller/widgets/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabsPageController;
  int _selectedTab = 0;
  @override
  void initState() {
    _tabsPageController = PageController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView(
                  controller: _tabsPageController,
                  onPageChanged: (num) {
                    setState(() {
                      _selectedTab = num;
                    });
                  },
                  children: [
                    HomeTab(),
                    SearchTab(),
                    CartTab(),
                    ProfileTab(),
                  ],
                ),
              ),
              BottomTabBar(
                selectedTab: _selectedTab,
                tabPressed: (num) {
                  _tabsPageController.animateToPage(num,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeOut);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
