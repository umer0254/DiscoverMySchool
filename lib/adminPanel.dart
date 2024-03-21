import 'dart:convert';

import 'package:discovermyschool/allSchools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'models/Schools.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

//
// class _AdminPanelState extends State<AdminPanel> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text("data"),
//
//       ),
//     );
//   }
// }
class _AdminPanelState extends State<AdminPanel> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: All Schools',
  //     style: optionStyle,
  //   ),
  //   // Text(
  //   //   'Index 2: School',
  //   //   style: optionStyle,
  //   // ),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  bool isLoading = false;
  List<School> SchoolsList = [];

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
          title: Text("Unapproved Schools",style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.lightBlue),
      body: (isLoading && SchoolsList.isEmpty)
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue,
              ),
            )
          : Column(
              children: [
                Stack(
                  children: <Widget>[],
                ),
                Expanded(
                  child: ListView.builder( //Card View Unapproved Schools//
                      itemCount: SchoolsList.length + 1,
                      itemBuilder: (context, index) {
                        if (index < SchoolsList.length) {
                          var c = SchoolsList[index];
                          return Card(
                            margin: EdgeInsets.all(8),
                            elevation: 1,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: InkWell(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: [
                                        Container(
                                            width: 120,
                                            child: Text("School Name",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text(
                                          "${c.schoolName}",
                                        ),
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                    //   children: [
                                    // IconButton(onPressed: () {
                                    //
                                    // }, icon: Icon(Icons.check),iconSize: 30),
                                    //
                                    //   ],
                                    // ),

                                    Wrap(
                                      children: [
                                        Container(
                                            width: 120,
                                            child: Text("Email",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text("${c.email}"),
                                      ],
                                    ),

                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 120,
                                            child: Text("School Type",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(
                                            child: Text(
                                          c.board ?? "",
                                          maxLines: null,
                                        )),
                                      ],
                                    ),

                                    Wrap(
                                      children: [
                                        Container(
                                            width: 120,
                                            child: Text("Admission Fee",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text("${c.admissionFee}"),
                                      ],
                                    ),

                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 120,
                                            child: Text("Admission Status ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(
                                            child: Text(
                                          c.admissionStatus ?? "",
                                          maxLines: null,
                                        )),
                                      ],
                                    ),Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 120,
                                            child: Text("City",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Expanded(
                                            child: Text(
                                          c.city ?? "",
                                          maxLines: null,
                                        )),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Container(
                                            width: 120,
                                            child: Text("Registration Date",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text("${c.createdAt ?? ""}"),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Container(width: 120,child: Text("Registration Date",style: TextStyle(fontWeight: FontWeight.bold))),
                                        IconButton(
                                            onPressed: () {
                                              approval(c.id);
                                            },
                                            icon: Icon(Icons.check,color: Colors.green,semanticLabel: "Approve"),
                                            iconSize: 30),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.close,color: Colors.red),
                                            iconSize: 30),
                                      ],
                                    ),
                                  ],
                                ),
                                // onTap: () {
                                //   // Navigator.push(context, MaterialPageRoute(builder: (context) => SpecificLocation(id: c.location?.street.id??0),));
                                //
                                // },
                              ),
                            ),
                          );
                        }
                      }),
                )
              ],
            ),
      drawer: drawer()
      // Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.lightBlue,
      //         ),
      //         child: Text('Menu',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 29)),
      //       ),
      //       ListTile(
      //         title: const Text('Home'),
      //         selected: _selectedIndex == 0,
      //         onTap: () {
      //           // Update the state of the app
      //           _onItemTapped(0);
      //           // Then close the drawer
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('All Schools'),
      //         selected: _selectedIndex == 1,
      //         onTap: () {
      //           // Update the state of the app
      //           _onItemTapped(1);
      //           // Then close the drawer
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => allSchools(),
      //               ));
      //         },
      //       ),
      //       // ListTile(
      //       //   title: const Text('School'),
      //       //   selected: _selectedIndex == 2,
      //       //   onTap: () {
      //       //     // Update the state of the app
      //       //     _onItemTapped(2);
      //       //     // Then close the drawer
      //       //     Navigator.pop(context);
      //       //   },
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }

  apidata() async {
    String url;
    url = 'http://127.0.0.1:8000/api/getUnapprovedSchools';
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);

        final List<dynamic> items = data;

        var schoolData = items.map((item) => School.fromJson(item)).toList();
        SchoolsList.addAll(schoolData);

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
  approval(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token=prefs.get('Token');
    String url;
    url = 'http://127.0.0.1:8000/api/approveSchool/${id}';
    try {

      final response = await http.put(Uri.parse(url),headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AdminPanel(),), (route) => false);

      }
    }catch(e){
      print(e);
      }

  }


}

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPanel(),));
            },
          ),
          ListTile(
            title: const Text('All Schools',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
            selected: _selectedIndex == 1,
            onTap: () {
              // Update the state of the app
              _onItemTapped(1);
              // Then close the drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => allSchools(),
                  ));
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

Future<void> alert(BuildContext context) {
  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token=prefs.get('Token');
    String url;
    url = 'http://127.0.0.1:8000/api/logout';
    try {

      final response = await http.post(Uri.parse(url),headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => login(),
            ),
                (route) => false);

      }
    }catch(e){
      print(e);
    }
  }
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return AlertDialog(
              title: const Text('Are you sure you want to logout?'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                     logout();
                    },
                    child: Text("OK")) ,
                TextButton(
                    onPressed: () {
                     Navigator.pop(context);
                    },
                    child: Text("Cancel")),
              ],
            );
          },
        );
      });

}



