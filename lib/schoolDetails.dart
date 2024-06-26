import 'dart:convert';

import 'package:discovermyschool/models/Schools.dart';
import 'package:discovermyschool/models/Students.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolDetails extends StatefulWidget {
  final int id;

  const SchoolDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<SchoolDetails> createState() => _SchoolDetailsState();
}

class _SchoolDetailsState extends State<SchoolDetails> {
  List<School> SchoolsList = [];
  bool isLoading = false;
  final Uri _url = Uri.parse('https://flutter.dev');
  int selected = 1;
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    apidata();
    loadProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("School Details"),
        backgroundColor: Colors.lightBlue,
      ),
      body: (isLoading && SchoolsList.isEmpty)
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.lightBlue,
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (SchoolsList.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    SchoolsList[0].schoolImage,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : Center(
                        child: CircularProgressIndicator(
                          value: progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes!,
                          color: Colors.lightBlue,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
              SizedBox(height: 16),
              Text(
                "Mission Statement",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 8),
              Text(
                SchoolsList.isNotEmpty
                    ? SchoolsList[0].missionStatement
                    : '',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Facilities",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 8),
              Text(
                SchoolsList.isNotEmpty ? SchoolsList[0].facilities : '',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Extra Curricular Activities",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 8),
              Text(
                SchoolsList.isNotEmpty
                    ? SchoolsList[0].extracurricularActivities
                    : '',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Principal",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 8),
              Text(
                SchoolsList.isNotEmpty ? SchoolsList[0].principalName : '',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Education",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                SchoolsList.isNotEmpty
                    ? SchoolsList[0].principalQualifications
                    : '',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Biography",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                SchoolsList.isNotEmpty
                    ? SchoolsList[0].principalBiography
                    : '',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ElevatedButton(
                      onPressed: () {
                        _dialogBuilder(context);
                      },
                      child: Text(
                        "Apply Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ElevatedButton(
                      onPressed: _launchUrl,
                      child: Text(
                        "Visit Website",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  apidata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('Token');
    print(widget.id);

    try {
      setState(() {
        isLoading = true;
      });

      Response response = await get(
        Uri.parse('http://10.0.2.2:8000/api/getSchoolDetails/${widget.id}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data['message']);
        var schoolData = School.fromJson(data['schools']);
        SchoolsList.add(schoolData);
        print("success");
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  apply() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('Token');
    print(widget.id);
    try {
      Response response = await post(
        Uri.parse('http://10.0.2.2:8000/api/apply'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "school_id": widget.id.toString(),
          "student_id": selected.toString(),
        },
      );
      if (response.statusCode == 201) {
        print("frrrrrrrrrrrrrr");
        var data = json.decode(response.body);
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Select Any One Profile'),
              content: Column(
                children: [
                  for (Student student in students)
                    RadioListTile(
                      value: student.id,
                      groupValue: selected,
                      onChanged: (value) {
                        setStateSB(() {
                          selected = value!;
                        });
                      },
                      title: Text(student.studentName),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    apply();
                  },
                  child: Text("Confirm"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  loadProfiles() async {
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
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        final List<dynamic> items = data['students'];
        var studentData = items.map((item) => Student.fromJson(item)).toList();
        students.addAll(studentData);

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
