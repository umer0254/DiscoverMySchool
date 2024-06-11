import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:discovermyschool/ProfileList.dart';
import 'package:discovermyschool/adminPanel.dart';
import 'package:discovermyschool/login.dart';
import 'package:discovermyschool/schoolDetails.dart';
import 'package:discovermyschool/searchFilter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/Schools.dart';

class SchoolSearchList extends StatefulWidget {
  const SchoolSearchList({super.key});

  @override
  State<SchoolSearchList> createState() => _SchoolSearchListState();
}

class _SchoolSearchListState extends State<SchoolSearchList> {
  bool isLoading = false;
  List<School> schoolsList = [];
  dynamic result;
  var search = TextEditingController();

  @override
  void initState() {
    super.initState();
    apidata();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is a good place to show a dialog asking the user to allow notifications
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Schools"),
        backgroundColor: Colors.lightBlue,
      ),
      drawer: Drawer1(),
      body: (isLoading && schoolsList.isEmpty)
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.lightBlue,
        ),
      )
          : Column(
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchBar(
              controller: search,
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                // Optional tap action
              },
              onChanged: (_) {
                // Optional change action
              },
              trailing: <Widget>[
                Tooltip(
                  message: 'Search',
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        apidata();
                      });
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Searchfilter(),
                        ),
                      );
                      setState(() {
                        apidata();
                      });
                    },
                    icon: Icon(Icons.filter_list_alt))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: schoolsList.length,
                itemBuilder: (context, index) {
                  var c = schoolsList[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SchoolDetails(id: c.id)),
                        );
                      },
                      title: Text(c.schoolName ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text("Email: ${c.email}"),
                          SizedBox(height: 5),
                          Text("School Type: ${c.board ?? ""}"),
                          SizedBox(height: 5),
                          Text("Admission Fee: ${c.admissionFee}"),
                          SizedBox(height: 5),
                          Text("Tuition Fee: ${c.tuitionFee}"),
                          SizedBox(height: 5),
                          Text(
                              "Admission Status: ${c.admissionStatus ?? ""}"),
                          SizedBox(height: 5),
                          Text(
                              "Registration Date: ${c.createdAt ?? ""}"),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  );
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
        schoolsList.clear();
      });

      Map<String, dynamic> requestBody = {
        "school_name": search.text.toString() ?? "",
      };

      // Check if a search filter has been applied
      if (result != null && result is List<dynamic>) {
        // Construct the request body with search filter parameters
        requestBody = {
          "school_name": search.text.toString(),
          "max_tuition_fee": result[0] ?? "",
          "area": result[3] ?? "",
          "city": result[2] ?? "",
          "board": result[1] ?? ""
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
        schoolsList.addAll(schoolData);
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}

class Drawer1 extends StatefulWidget {
  const Drawer1({super.key});

  @override
  State<Drawer1> createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> {
  var  name;
   var email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
            accountName: Text(name??"", style: TextStyle(fontSize: 18)),
            accountEmail: Text(email??""),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'U',
                style: TextStyle(fontSize: 30.0, color: Colors.blue),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home', style: TextStyle(fontSize: 18)),
            selected: _selectedIndex == 0,
            onTap: () {
              _onItemTapped(0);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SchoolSearchList(),
                ),
                    (route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profiles', style: TextStyle(fontSize: 18)),
            selected: _selectedIndex == 1,
            onTap: () {
              _onItemTapped(1);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileList(),
                ),
                    (route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout', style: TextStyle(fontSize: 18)),
            selected: _selectedIndex == 2,
            onTap: () {
              _onItemTapped(2);
              alert(context);
            },
          ),
        ],
      ),
    );
  }
  getdata() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token');
      print(token);
      String url;
      url = 'http://10.0.2.2:8000/api/user';
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        setState(() {
          name = json['first_name'] + " " + json['last_name'];
          email = json['email'];
        });
      }
    }catch(e){

    }

  }
}
//
// void alert(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Logout"),
//         content: Text("Are you sure you want to logout?"),
//         actions: <Widget>[
//           TextButton(
//             child: Text("Cancel"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: Text("Logout"),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login(),), (route) => false);
//               // Perform logout operation
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
