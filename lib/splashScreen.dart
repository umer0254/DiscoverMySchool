import 'dart:async';

import 'package:discovermyschool/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {return login();},));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child:    Container(
            child: Image.asset(height: 300,"assets/logot.png"),
          ),
        )

    );
  }
}
