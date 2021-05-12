import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_seller/screens/home.dart';
import 'package:mobile_seller/screens/login.dart';
import 'package:mobile_seller/widgets/constants.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Container(
                child: Text(
                  snapshot.error,
                  style: Constants.regularHeading,
                ),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnap) {
              if (streamSnap.hasError) {
                return Scaffold(
                  body: Center(
                    child: Container(
                      child: Text(
                        streamSnap.error,
                        style: Constants.regularHeading,
                      ),
                    ),
                  ),
                );
              } else if (streamSnap.connectionState == ConnectionState.active) {
                //if user == empty that means we are not logged in
                User _user = streamSnap.data;
                if (_user == null) {
                  return LoginPage();
                } else {
                  return HomePage();
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
