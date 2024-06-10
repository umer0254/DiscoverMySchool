import 'dart:convert';

import 'package:discovermyschool/schoolScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditSchoolProfileScreen extends StatefulWidget {
  final Map<String, dynamic> schoolProfile;

  EditSchoolProfileScreen({required this.schoolProfile});

  @override
  _EditSchoolProfileScreenState createState() =>
      _EditSchoolProfileScreenState();
}

class _EditSchoolProfileScreenState extends State<EditSchoolProfileScreen> {
  var _admissionFeeController=TextEditingController() ;
  var _admissionStatusController=TextEditingController() ;
  var _contactNumberController=TextEditingController() ;
  var _tuitionFeeController=TextEditingController() ;
  var _principalNameController=TextEditingController() ;
  var _principalBiographyController=TextEditingController() ;
  var _extracurricularActivitiesController=TextEditingController() ;
  static const List<String> list = <String>['Open', 'Closed'];
  String dropdownValue = list.first;
  // late TextEditingController _admissionStatusController;
  // late TextEditingController _contactNumberController;
  // late TextEditingController _tuitionFeeController;
  // late TextEditingController _principalNameController;
  // late TextEditingController _principalBiographyController;
  // late TextEditingController _extracurricularActivitiesController;

  @override
  void initState() {
    super.initState();
    // _admissionFeeController =
    //     TextEditingController(text: widget.schoolProfile['admission_fee'] ?? '');
    // _admissionStatusController = TextEditingController(
    //     text: widget.schoolProfile['admission_status'] ?? '');
    // _contactNumberController =
    //     TextEditingController(text: widget.schoolProfile['contact_number'] ?? '');
    // _tuitionFeeController =
    //     TextEditingController(text: widget.schoolProfile['tuition_fee'] ?? '');
    // _principalNameController = TextEditingController(
    //     text: widget.schoolProfile['principal_name'] ?? '');
    // _principalBiographyController = TextEditingController(
    //     text: widget.schoolProfile['principal_biography'] ?? '');
    // _extracurricularActivitiesController = TextEditingController(
    //     text: widget.schoolProfile['extracurricular_activities'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit School Profile',style: TextStyle(fontWeight: FontWeight.bold)),backgroundColor: Colors.lightBlue,
      ),
      drawer: const Drawer2(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _admissionFeeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Admission Fee',
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6)) ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: dropdownValue,
              // icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              // underline: Container(
              //   height: 2,
              //   color: Colors.deepPurpleAccent,
              // ),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6))),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _tuitionFeeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Tuition Fee',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _principalNameController,
                decoration: InputDecoration(labelText: 'Principal Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _principalBiographyController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(labelText: 'Principal Biography', border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _extracurricularActivitiesController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration:
                InputDecoration(labelText: 'Extracurricular Activities',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
              ),
            ),
            // SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call method to update profile data
                updateProfile();
              },
              child: Text('Update Profile',style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),style:ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');

    // Prepare the updated profile data
    Map<String, dynamic> updatedProfile = {};

    if (_admissionFeeController.text.isNotEmpty) {
      updatedProfile['admission_fee'] = _admissionFeeController.text.toString();
    }
    if (_admissionStatusController.text.isNotEmpty) {
      updatedProfile['admission_status'] = _admissionStatusController.text.toString();
    }
    if (_contactNumberController.text.isNotEmpty) {
      updatedProfile['contact_number'] = _contactNumberController.text.toString();
    }
    if (_tuitionFeeController.text.isNotEmpty) {
      updatedProfile['tuition_fee'] = _tuitionFeeController.text.toString();
    }
    if (_principalNameController.text.isNotEmpty) {
      updatedProfile['principal_name'] = _principalNameController.text.toString();
    }
    if (_principalBiographyController.text.isNotEmpty) {
      updatedProfile['principal_biography'] = _principalBiographyController.text.toString();
    }
    if (_extracurricularActivitiesController.text.isNotEmpty) {
      updatedProfile['extracurricular_activities'] = _extracurricularActivitiesController.text.toString();
    }

    // Convert the profile data to JSON
    String jsonProfile = jsonEncode(updatedProfile);

    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/updateProfile');
      var response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonProfile,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update Successfull")));
        print('Profile updated successfully');

        print(response.body);
      } else {
        // Handle error
        print('Failed to update profile. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
