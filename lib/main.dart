import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project1/homePage.dart';
import 'package:project1/loginPage.dart';

void main() {
  runApp(FlickTip());
}

class FlickTip extends StatefulWidget {
  @override
  State<FlickTip> createState() => _FlickTipState();
}

class _FlickTipState extends State<FlickTip> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            //build the login page if the connection is done
            if (snapshot.connectionState == ConnectionState.done) {
              return loginPage();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
