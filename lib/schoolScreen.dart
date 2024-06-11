import 'package:discovermyschool/Approvedapplication.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:discovermyschool/schoolProfile.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adminPanel.dart';
import 'login.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({Key? key});

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  late List<dynamic> applications = [];

  @override
  void initState() {
    super.initState();
    fetchApplications();
  }

  Future<void> fetchApplications() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.get('Token');
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/getschoollapplication'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        setState(() {
          applications = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching applications: $e');
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Applications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      drawer: const Drawer2(),
      body: applications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: applications.length,
        itemBuilder: (context, index) {
          final application = applications[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(application['student']['student_name']),
                  Text(application['status'])
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplicationDetailsScreen(application: application),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Drawer2 extends StatefulWidget {
  const Drawer2({Key? key});

  @override
  State<Drawer2> createState() => _Drawer2State();
}

class _Drawer2State extends State<Drawer2> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 10),
                Text('New Applications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            selected: _selectedIndex == 0,
            onTap: () {
              _onItemTapped(0);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SchoolScreen(),), (route) => false);
            },
          ),      ListTile(
            title: Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 10),
                Text('Approved Applications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            selected: _selectedIndex == 1,
            onTap: () {
              _onItemTapped(0);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => approvedapplications(),), (route) => false);
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 10),
                Text('Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            selected: _selectedIndex == 2,
            onTap: () {
              _onItemTapped(1);
            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => EditSchoolProfileScreen(schoolProfile:{}),), (route) => false);
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 10),
                Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
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
}



class ApplicationDetailsScreen extends StatelessWidget {
  final dynamic application;

  ApplicationDetailsScreen({required this.application});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Application Details: ${application['student']['student_name']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildDetailItem('Student Name', '${application['student']['student_name']}'),
          _buildDetailItem('Date of Birth', '${application['student']['date_of_birth']}'),
          _buildDetailItem('Father Name', '${application['student']['father_name']}'),
          _buildDetailItem('Father Occupation', '${application['student']['father_occupation']}'),
          _buildDetailItem('Father Education', '${application['student']['father_education']}'),
          _buildDetailItem('Mother Name', '${application['student']['mother_name']}'),
          _buildDetailItem('Mother Occupation', '${application['student']['mother_occupation']}'),
          _buildDetailItem('Mother Education', '${application['student']['mother_education']}'),
          _buildDetailItem('Address', '${application['student']['address']}'),
          _buildDetailItem('Father CNIC', '${application['student']['father_cnic']}'),
          _buildDetailItem('Student CNIC', '${application['student']['student_cnic']}'),
          _buildDetailItem('Applying for Class', '${application['student']['applying_for_class']}'),
          _buildDetailItem('Submitted On', '${application['student']['created_at']}'),
          // _buildDetailItem('Updated At', '${application['student']['updated_at']}'),
          ElevatedButton(onPressed: () {
            _dialogBuilder(context);

          }, child: Text("Give Remarks",style:   TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),style:  ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),)
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
  Future<void> _dialogBuilder(BuildContext context) {
    // Define the list of options for the dropdown button
    const List<String> options = ['approved', 'rejected'];
    String dropdownValue = options.first; // Initialize dropdown value
    var remarks=TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Application Approval'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Adjust the size of the content column
            children: [
              DropdownButtonFormField<String>(
                value: dropdownValue,
                onChanged: (String? value) {
                  // Update the dropdown value when the user selects an option
                  if (value != null) {
                    dropdownValue = value;
                  }
                },
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              TextField(
                controller: remarks,
                keyboardType: TextInputType.multiline,
                maxLines: null, // Allow multiple lines for remarks
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  labelText: "Enter Remarks",
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Perform the action with the selected values
                updateApplication(context,application['id'],dropdownValue,remarks.text.toString());
              },
              child: Text("Confirm"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            )
          ],
        );
      },
    );
  }

  Future<void> updateApplication(context,int id, String status, String remarks) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('Token');
    try {
      Response response = await put(
        Uri.parse(
            'http://10.0.2.2:8000/api/giveremarks/$id'),
        body: {
          "status": status,
          "remarks": remarks
        },headers: {
        'Authorization': 'Bearer $token',
      }
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Application Update Successful")));

      }
    }catch(e){
      print(e);

    }
  }


  void alert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Implement logout logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ),
                );
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}


