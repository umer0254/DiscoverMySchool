import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'models/Application.dart';
import 'models/Schools.dart'; // Import the School model

class Studentsubmission extends StatefulWidget {
  final int id;
  const Studentsubmission({Key? key, required this.id}) : super(key: key);

  @override
  State<Studentsubmission> createState() => _StudentsubmissionState();
}

class _StudentsubmissionState extends State<Studentsubmission> with TickerProviderStateMixin {
  List<Application> applicationlist = [];
  bool isLoading = false;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    apidata();
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync:this ,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Applications"),
        backgroundColor: Colors.lightBlue,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: applicationlist.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(applicationlist[index].school.schoolName), // Use actual data from applicationlist
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(applicationlist[index].status),
                  LinearProgressIndicator(
                    value: controller.value,
                    color: applicationlist[index].status.toLowerCase()=='approved'?Colors.green:applicationlist[index].status.toLowerCase()=='rejected'?Colors.red:Colors.lightBlue,
                    // semanticsLabel: 'Linear progress indicator',
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Text("Remarks",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
                  ),
                  Text(applicationlist[index].remarks),

                ],
              ), // Use actual data from applicationlist
              // Add more details as needed
            ),
          );
        },
      ),
    );
  }

  Future<void> apidata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('Token');

    try {
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/getstudentapplication/${widget.id}'),
        headers: {
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        // Clear the list before adding new items
        applicationlist.clear();

        for (var item in data) {
          // Construct Application object from JSON and add to the list
          Application application = Application.fromJson(item);
          applicationlist.add(application);
        }

        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }
}
