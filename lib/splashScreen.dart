import 'dart:async';
import 'dart:convert';

import 'package:discovermyschool/login.dart';
import 'package:discovermyschool/ProfileList.dart';
import 'package:discovermyschool/schoolScreen.dart';
import 'package:discovermyschool/schoolSearchListing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'adminPanel.dart';

class splashScreen extends StatefulWidget {
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),()
    {
      tokenValidity();
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
  tokenValidity() async {
    try{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token=prefs.getString('Token');
    print(token);
    String url;
    url='http://10.0.2.2/api/user';
      final response = await http.get(Uri.parse(url),headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final userType=json['user_type'];
        if(userType=="Parent"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => schoolSearchList(),));
        } else if(userType=="School"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SchoolScreen(),));
        }else if(userType=="Admin"){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => AdminPanel(),));
        }
      }else{

        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => login(),));


      }
    }
    catch(e){
      print(e);

    }
  }
}

