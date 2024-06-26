import 'dart:convert';

import 'package:discovermyschool/SignUp.dart';
import 'package:discovermyschool/adminPanel.dart';
import 'package:discovermyschool/ProfileList.dart';
import 'package:discovermyschool/schoolScreen.dart';
import 'package:discovermyschool/schoolSearchListing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: BottomNavigationBar(
        //   items: [ BottomNavigationBarItem(icon: IconButton(onPressed: () {
        //
        //   }, icon: Icon(Icons.home,color: Colors.black,)),label: "Login"),
        //     // BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
        //     BottomNavigationBarItem(icon: IconButton(onPressed: () {
        //         Navigator.push(context, MaterialPageRoute(builder: (context) => schoolSignup(),));
        //     }, icon: Icon(Icons.school_sharp,color: Colors.black,)),label: "School Registration")
        //
        //   ],
        // ),

      appBar: AppBar(
        title: const Text("DiscoverMySchool",style: TextStyle(fontWeight: FontWeight.bold)),
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
                        size: const Size.fromRadius(120), // Image radius
                        child: Image.asset("assets/logot.png"),
                      ),
                    )

                ),
              ),

              _MyFormFields()


            ],
          ),
        ),
      )


    );
  }
}

class _MyFormFields extends StatefulWidget {
  @override
  State<_MyFormFields> createState() => _MyFormFieldsState();
}

class _MyFormFieldsState extends State<_MyFormFields> {
  final _formKey = GlobalKey<FormState>();
  var email=TextEditingController();
  var password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child:  TextFormField(
                controller:email ,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill the field";
                  }
                  if(!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)){

                      return "Email Type Incorrect";
                    }
                  return null;

                },

                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Email / Nickname",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),


                style: const TextStyle(),
              ) )
          ,
        
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
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Eg: abc***",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
          )
          ,
          const SizedBox(
            height: 20,
          ),

          SizedBox(
            height: 50,
            width: 120,
            child:     ElevatedButton(
              onPressed: ()  {
                if (_formKey.currentState!.validate()) {}
                loginUser(email.text.toString(),password.text.toString());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,

              ),
              child: const Text("Login",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          TextButton(onPressed: () {

          }, child: const Text("Forget Password?",style: TextStyle(color: Colors.black),)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("New User?",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold)),
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {return SignUp();},));

              }, child: const Text("Sign Up",style: TextStyle(color: Colors.blue,fontWeight:FontWeight.bold)))
            ],
          )

        ],
      ),
    );
  }

loginUser(String email,String password ) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    Response response = await post(
      Uri.parse(
          'http://10.0.2.2:8000/api/userlogin'),
      body: {
        "email": email,
        "password": password
      },
    );
    if(response.statusCode==200){
      final body = response.body;
      final json = jsonDecode(body);
      final userType=json['data']['user_type'];
      final bearertoken=json['data']['token'];
      print(bearertoken);
      prefs.setString('Token', bearertoken);
      if(userType=="Parent"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SchoolSearchList(),));
      } else if(userType=="School"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SchoolScreen(),));
      }else if(userType=="Admin"){
       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => AdminPanel(),));
      }
    }else{
      final body = response.body;
      final json = jsonDecode(body);
      final message=json['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

    }
  }
  catch(e){

  }

}
}


