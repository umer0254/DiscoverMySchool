import 'package:discovermyschool/schoolScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:discovermyschool/schoolProfile.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adminPanel.dart';
import 'login.dart';

class approvedapplications extends StatefulWidget {
  const approvedapplications({Key? key});

  @override
  State<approvedapplications> createState() => _approvedapplicationsState();
}

class _approvedapplicationsState extends State<approvedapplications> {
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
        Uri.parse('http://10.0.2.2:8000/api/approvedapplications'),
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
          "Approved Applications",
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
          _buildDetailItem(
              'Student Name', '${application['student']['student_name']}'),
          _buildDetailItem(
              'Date of Birth', '${application['student']['date_of_birth']}'),
          _buildDetailItem(
              'Father Name', '${application['student']['father_name']}'),
          _buildDetailItem('Father Occupation',
              '${application['student']['father_occupation']}'),
          _buildDetailItem('Father Education',
              '${application['student']['father_education']}'),
          _buildDetailItem(
              'Mother Name', '${application['student']['mother_name']}'),
          _buildDetailItem('Mother Occupation',
              '${application['student']['mother_occupation']}'),
          _buildDetailItem('Mother Education',
              '${application['student']['mother_education']}'),
          _buildDetailItem('Address', '${application['student']['address']}'),
          _buildDetailItem(
              'Father CNIC', '${application['student']['father_cnic']}'),
          _buildDetailItem(
              'Student CNIC', '${application['student']['student_cnic']}'),
          _buildDetailItem('Applying for Class',
              '${application['student']['applying_for_class']}'),
          _buildDetailItem(
              'Submitted On', '${application['student']['created_at']}'),_buildDetailItem(
              'Application Remarks', '${application['remarks']}'),
          // _buildDetailItem('Updated At', '${application['student']['updated_at']}'),

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
}


