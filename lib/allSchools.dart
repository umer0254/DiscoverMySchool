import 'dart:convert';

import 'package:discovermyschool/adminPanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/Schools.dart';

class allSchools extends StatefulWidget {
  const allSchools({super.key});

  @override
  State<allSchools> createState() => _allSchoolsState();
}

class _allSchoolsState extends State<allSchools> {
  bool isLoading=false;
  List<School> SchoolsList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apidata();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("All Schools"),backgroundColor:  Colors.lightBlue,
      ),drawer: drawer(),
      body: (isLoading && SchoolsList.isEmpty)? Center(
      child: CircularProgressIndicator(
        color: Colors.lightBlue,
      ),
    ):
    Column(
      children: [
        Stack(
          children: <Widget>[
            // Container(
            //   width: MediaQuery.sizeOf(context).width,
            //   height: 200.0,
            //   decoration: new BoxDecoration(
            //     color: Colors.deepPurple,
            //     borderRadius: BorderRadius.vertical(
            //         bottom: Radius.elliptical(
            //             MediaQuery.of(context).size.width, 100.0)),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text("Crimes of Category "+widget.category ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16))
            //     ],
            //   ),
            // ),
          ],
        ),
        // SingleChildScrollView(
        //   child: ListTile(
        //     title: Text(companies[0].title!),
        //   )
        // ),
        Expanded(
          child: ListView.builder(
              itemCount: SchoolsList.length + 1,
              itemBuilder: (context, index) {
                if (index < SchoolsList.length) {
                  var c = SchoolsList[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    elevation: 1,
                    child:Container(
                      margin: EdgeInsets.all(10),
                      // padding:EdgeInsets.all(8),
                      // width:MediaQuery.sizeOf(context).width,
                      child:InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Table(
                            //   border: TableBorder.all(),
                            //   children: [
                            //     buildTableRow('Heading One         ', 'Value'),
                            //     buildTableRow('Heading Two   ', 'Value'),
                            //     // Add more rows as needed
                            //   ],
                            // ),
                            Wrap(
                              children: [
                                Container(width: 120,child: Text("School Name",style: TextStyle(fontWeight: FontWeight.bold))),
                                Text("${c.schoolName}",),
                              ],
                            ),

                            Wrap(
                              children: [
                                Container(width: 120,child: Text("Email",style: TextStyle(fontWeight: FontWeight.bold))),
                                Text("${c.email}"),
                              ],
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width: 120,child: Text("School Type",style: TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(child: Text(c.schoolType??"",maxLines: null,)),
                              ],
                            ),

                            Wrap(
                              children: [
                                Container(width: 120,child: Text("Admission Fee",style: TextStyle(fontWeight: FontWeight.bold))),
                                Text("${c.admissionFee}"),
                              ],
                            ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(width:120 ,child: Text("Admission Status ",style: TextStyle(fontWeight: FontWeight.bold))),
                                  Expanded(child: Text(c.admissionStatus??"" ,maxLines: null,)),
                                ],
                              ),
                              Wrap(
                                children: [
                                  Container(width: 120,child: Text("Registration Date",style: TextStyle(fontWeight: FontWeight.bold))),
                                  Text("${c.createdAt??""}"),
                                ],
                              ),




                          ],
                        ),
                        // onTap: () {
                        //   // Navigator.push(context, MaterialPageRoute(builder: (context) => SpecificLocation(id: c.location?.street.id??0),));
                        //
                        // },
                      ) ,
                    ),

                  );
                }
              }),
        )
      ],
    ),
    );
  }
  apidata() async {
    String url;
 url='http://10.0.2.2:8000/api/getAllSchools';
    try {
      setState(() {
        isLoading=true;
      });
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {

        var data = json.decode(response.body);
        print(data);
        final List<dynamic> items = data['schools'];
        var schoolData = items.map((item) => School.fromJson(item)).toList();
        SchoolsList.addAll(schoolData);


        setState(() {
          isLoading=false;
        });

      }
      else{
        setState(() {
          isLoading=false;
        });



      }
    } catch (e) {
      print(e);
    }
  }
}
