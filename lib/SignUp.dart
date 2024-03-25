import 'dart:convert';

import 'package:discovermyschool/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User Registration"),
          backgroundColor: Colors.lightBlue,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(100), // Image radius
                          child: Image.asset("assets/logot.png"),
                        ),
                      )),
                ),
                // Container(height: 20,),
                _signupFormFields()
              ],
            ),
          ),
        ));
  }
}

class _signupFormFields extends StatefulWidget {
  @override
  State<_signupFormFields> createState() => __signupFormFields();
}

//

//       ),
//         color: Colors.blue,
//         height: 2,
//       underline: Container(
//       style: const TextStyle(color: Colors.blue),
//       elevation: 16,
//       icon: const Icon(Icons.arrow_downward),
//       value: dropdownValue,
//     return DropdownButton<String>(
//   Widget build(BuildContext context) {
//   @override
//
//
// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//
// }
//   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
//   @override
//
//   const DropdownButtonExample({super.key});
class __signupFormFields extends State<_signupFormFields> {
  final _formKey = GlobalKey<FormState>();
  var selectedValue = "";
  var first_name = TextEditingController();
  var email = TextEditingController();
  var last_name = TextEditingController();
  var phone_number = TextEditingController();
  var password = TextEditingController();
  var c_password = TextEditingController();

  // var user_type=TextEditingController();
  static const List<String> list = <String>['Parent', 'School'];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 35, 10),
              child: TextFormField(
                controller: first_name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "First Name",
                  hintText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child: TextFormField(
                controller: last_name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Last Name",
                  hintText: "last name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child: TextFormField(
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return "Email Type Incorrect";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "eg:@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child: TextFormField(
                controller: phone_number,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Contact Number",
                  hintText: "02134-----",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
            child: TextFormField(
              controller: password,
              obscureText: true,
              obscuringCharacter: "*",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please fill the field";
                }
                if (!RegExp(r"^.{6,}$").hasMatch(value)) {
                  return "Password must be more than 6 Characters";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
            child: TextFormField(
              controller: c_password,
              obscureText: true,
              obscuringCharacter: "*",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please fill the field";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
            child: DropdownButtonFormField<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
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
          SizedBox(
            height: 50,
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
                registerUser(
                    first_name.text.toString(),
                    last_name.text.toString(),
                    email.text.toString(),
                    password.text.toString(),
                    c_password.text.toString(),
                    phone_number.text.toString(),
                    dropdownValue);
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
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already Registered?",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return login();
                      },
                    ));
                  },
                  child: const Text("Login",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)))
            ],
          )
        ],
      ),
    );
  }

  registerUser(String f_name, String l_name, String email, String password,
      String c_password, String phone_number, String user_type) async {
    try {
      Response response = await post(
        Uri.parse('http://10.0.2.2:8000/api/userregistrattion'),
        body: {
          "email": email,
          "password": password,
          "c_password": c_password,
          "first_name": f_name,
          "last_name": l_name,
          "phone_number": phone_number,
          "user_type": user_type,
        },
      );

      if (response.statusCode == 200) {
        alert(context);
      } else {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Failed")));

      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> alert(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setStateSB) {
              return AlertDialog(
                title: const Text('Registration Successful'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => login(),
                            ),
                            (route) => false);
                      },
                      child: Text("OK")),
                ],
              );
            },
          );
        });
  }
}
// class DropdownButtonExample extends StatefulWidget {
//       onChanged: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
