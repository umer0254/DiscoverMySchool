import 'dart:convert';

import 'package:discovermyschool/ProfileList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Student Profile Creation",
          ),
          backgroundColor: Colors.lightBlue),
      body: SingleChildScrollView(child: studentProfile()),
    );
  }
}

class studentProfile extends StatefulWidget {
  @override
  State<studentProfile> createState() => __studentProfileFormFields();
}

class __studentProfileFormFields extends State<studentProfile> {
  final _formKey = GlobalKey<FormState>();
  var selectedValue = "";
  var studentname = TextEditingController();
  var mothername = TextEditingController();
  var fathername = TextEditingController();
  var fatheroccupation = TextEditingController();
  var motheroccupation = TextEditingController();
  var address = TextEditingController();
  var fathercnic = TextEditingController();
  var studentcnic = TextEditingController();
  var data0fbirth = TextEditingController();
  var fatherEducation = TextEditingController();
  var motherEducation = TextEditingController();

  // var user_type=TextEditingController();
  static const List<String> list = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
              child: TextFormField(
                controller: studentname,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Student Name",
                  // hintText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 35, 10),
              child: TextFormField(
                controller: studentcnic,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Student Cnic/B-Form",
                  // hintText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 35, 10),
              child: TextFormField(
                controller: data0fbirth,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  if (!RegExp(r"^\d{4}-\d{2}-\d{2}$").hasMatch(value)) {
                    return "Invalid Format YYYY-MM-DD";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Date Of Birth",
                  hintText: "YYYY-MM-DD",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child: TextFormField(
                controller: fathername,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Father's Name",
                  // hintText: "last name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child: TextFormField(
                controller: fatherEducation,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Father's Education",
                  // hintText: "last name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child: TextFormField(
                controller: fathercnic,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Father's Cnic",
                  // hintText: "last name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child: TextFormField(
                controller: mothername,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Mother Name",
                  // hintText: "eg:@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )), Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child: TextFormField(
                controller: motherEducation,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Mother Education",
                  // hintText: "eg:@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child: TextFormField(
                controller: fatheroccupation,
                // keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Father Occupation",
                  // hintText: "02134-----",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
            child: TextFormField(
              controller: motheroccupation,
              // obscureText: true,
              // obscuringCharacter: "*",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please fill the field";
                }

                return null;
              },
              decoration: InputDecoration(
                  labelText: "Mother Occupation",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
            child: TextFormField(
              controller: address,
              // obscureText: true,
              // obscuringCharacter: "*",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please fill the field";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
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
                  labelText: "Applying For Class",
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
          SizedBox(
            height: 50,
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  registerUser(
                    studentname.text.toString(),
                    studentcnic.text.toString(),
                    data0fbirth.text.toString(),
                    fathername.text.toString(),
                    fathercnic.text.toString(),
                    fatherEducation.text.toString(),
                    fatheroccupation.text.toString(),
                    mothername.text.toString(),
                    motherEducation.text.toString(),
                    motheroccupation.text.toString(),
                    address.text.toString(),
                    dropdownValue.toString(),
                  );
                }

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "Register",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  registerUser(
    String student_name,
    String student_cnic,
    String dob,
    String fathername,
    String fathercnic,
    String fathereducation,
    String fatheroccupation,
    String mothername,
    String mothereducation,
    String motheroccupation,
    String address,
    String aaplyingfor,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('Token');


// Inside your registerUser function
    try {
      Response response = await post(
        Uri.parse('http://10.0.2.2:8000/api/studentregistration'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "student_name": student_name,
          "date_of_birth": dob,
          "father_occupation": fatheroccupation,
          "father_name": fathername,
          "father_education":fathereducation,
          "mother_name": mothername,
          "mother_education": mothereducation,
          "mother_occupation": motheroccupation,
          "address": address,
          "father_cnic": fathercnic,
          "student_cnic": student_cnic,
          "applying_for_class": aaplyingfor,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        // Assuming the response contains a message field indicating success
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ProfileList(),));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'])),

        );
      } else {
        // Handle other status codes
        print(utf8.decode(response.bodyBytes));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile Creation Failed")),
        );
      }
    } catch (e) {
      print(e);
    }

  }


}
