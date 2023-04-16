import 'package:flutter/material.dart';
import 'package:project1/homePage.dart';

void main() {
  runApp(FlickTip());
}

class FlickTip extends StatefulWidget {
  @override
  State<FlickTip> createState() => _FlickTipState();
}

class _FlickTipState extends State<FlickTip> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(debugShowCheckedModeBanner: false, home: homeScreen());
  }
}
