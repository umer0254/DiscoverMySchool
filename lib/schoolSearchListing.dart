import 'dart:convert';

import 'package:discovermyschool/ProfileList.dart';
import 'package:discovermyschool/adminPanel.dart';
import 'package:discovermyschool/schoolDetails.dart';
import 'package:discovermyschool/searchFilter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'models/Schools.dart';

class schoolSearchList extends StatefulWidget {
  const schoolSearchList({super.key});

  @override
  State<schoolSearchList> createState() => _schoolSearchListState();
}

class _schoolSearchListState extends State<schoolSearchList> {
  bool isLoading=false;
  List<School> SchoolsList=[];
  dynamic result;
   var search=TextEditingController();
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
      ),drawer: drawer1(),
      body: (isLoading && SchoolsList.isEmpty)? Center(
        child: CircularProgressIndicator(
          color: Colors.lightBlue,
        ),
      ):
      Column(
        children: [
          SizedBox(height: 15,),
          Stack(
            children: <Widget>[
              // SizedBox(height: 30,),
              // SearchBar(),
              SearchBar(
                controller: search,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  // controller.openView();
                },
                onChanged: (_) {
                  // controller.openView();
                },
                // leading: const Icon(Icons.search),
                trailing: <Widget>[
                  Tooltip(
                    message: 'Change brightness mode',
                    child: IconButton(
                      // isSelected: isDark,
                      onPressed: () {
                        setState(() {
                          apidata();
                        });
                      },
                      icon: Icon(Icons.search),

                      // selectedIcon: const Icon(Icons.brightness_2_outlined),
                    ),
                  ),
                  IconButton(
                    // isSelected: isDark,
                      onPressed: () async {
                        result= await Navigator.push(context, MaterialPageRoute(builder: (context) => Searchfilter(),));

                        setState(() {
                         apidata();
                        });
                      },
                      icon: Icon(Icons.filter_list_alt)
                  )

                ],
              )
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
            child: ListView.builder( //CardView for all schools//
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SchoolDetails(id: c.id)),
                            );

                          },
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
                                  Expanded(child: Text(c.board??"",maxLines: null,)),
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

    try {
      setState(() {
        isLoading = true;
        SchoolsList.clear();
        print("fdkdknsldsk");
      });

      Map<String, dynamic> requestBody = {
        "school_name":search.text.toString()??"",
      };

      // Check if a search filter has been applied
      if (result != null && result is List<dynamic>) {
        // Construct the request body with search filter parameters
        requestBody = {
          "school_name":search.text.toString(),
          "max_tuition_fee": result[0]??"",
          "area": result[3]??"",
          "city": result[2]??"",
          "board": result[1]??""
        };
      }

      // Make the API request with the constructed body
      Response response = await post(
        Uri.parse('http://10.0.2.2:8000/api/getAllSchools'),
        body: requestBody,
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        final List<dynamic> items = data['schools'];
        var schoolData = items.map((item) => School.fromJson(item)).toList();
        SchoolsList.addAll(schoolData);
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

}
class drawer1 extends StatefulWidget {
  const drawer1({super.key});

  @override
  State<drawer1> createState() => _drawerState();
}

class _drawerState extends State<drawer1> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
            child: Text('Menu',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
          ),
          ListTile(
            title: const Text('Home',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
            selected: _selectedIndex == 0,
            onTap: () {
              // Update the state of the app
              _onItemTapped(0);
              // Then close the drawer
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => schoolSearchList(),), (route) => false);
            },
          ),
          ListTile(
            title: const Text('My Profiles',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
            selected: _selectedIndex == 1,
            onTap: () {
              // Update the state of the app
              _onItemTapped(1);
              // Then close the drawer
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProfileList(),), (route) => false);
            },
          ),
          ListTile(
            title: const Text('Logout',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            selected: _selectedIndex == 2,
            onTap: () {
              // Update the state of the app
              _onItemTapped(2);
              // Then close the drawer
              alert(context);
            },
          ),
        ],
      ),
    );
  }
}