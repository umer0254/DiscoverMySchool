import 'dart:convert';

import 'package:discovermyschool/models/Students.dart';
import 'package:discovermyschool/schoolSearchListing.dart';
import 'package:discovermyschool/studentProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileList extends StatefulWidget {
  const ProfileList({super.key});

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  bool isLoading = false;
  List<Student> StudentList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apidata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Profiles"),
          backgroundColor: Colors.lightBlue,
          actions: [IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfile(),)), icon: Icon(Icons.add,color: Colors.black),)],
        ),drawer:drawer1(),
        body: Scaffold(
            body: (isLoading && StudentList.isEmpty)
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.lightBlue,
                    ),
                  )
                : Column(children: [
                    Stack(
                      children: <Widget>[],
                    ),
                    Expanded(
                        child: ListView.builder(
                            //Card View Unapproved Schools//
                            itemCount: StudentList.length + 1,
                            itemBuilder: (context, index) {
                              if (index < StudentList.length) {
                                var c = StudentList[index];
                                return Card(
                                    margin: EdgeInsets.all(8),
                                    elevation: 1,
                                    child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: InkWell(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Wrap(
                                                children: [
                                                  Container(
                                                      width: 120,
                                                      child: Text("Name",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Text("${c.studentName}"),
                                                ],
                                              ),
                                              Wrap(
                                                children: [
                                                  Container(
                                                      width: 120,
                                                      child: Text("Father Name",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Text("${c.fatherName}"),
                                                ],
                                              ),
                                              Wrap(
                                                children: [
                                                  Container(
                                                      width: 120,
                                                      child: Text(
                                                          "Applying For Class",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Text("${c.applyingForClass}"),
                                                ],
                                              ),
                                            ]))));
                              }
                            })
                    ),
                  
            ])));
  }

  apidata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('Token');
    try {
      setState(() {
        isLoading = true;
      });
      Response response = await get(
          Uri.parse('http://10.0.2.2:8000/api/my-students'),
          headers: {
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        final List<dynamic> items = data['students'];
        var schoolData = items.map((item) => Student.fromJson(item)).toList();
        StudentList.addAll(schoolData);

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
