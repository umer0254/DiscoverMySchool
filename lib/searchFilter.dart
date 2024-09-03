import 'package:discovermyschool/allSchools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Searchfilter extends StatefulWidget {
  const Searchfilter({super.key});

  @override
  State<Searchfilter> createState() => _SearchfilterState();
}

class _SearchfilterState extends State<Searchfilter> {
  static const List<String> list = <String>['Aga Khan', 'Cambridge','Federal','Matric'];
  static const List<String> list1 = <String>['Karachi', 'Lahore','Islamabad','Multan'];
  static const List<String> list2 = <String>['Clifton', 'Defence','Gulshan-e-Iqbal','Gulistan-e-Johar','North Nazimabad'];
   String dropdownValue="";
  String dropdownValue1 = "";
  String dropdownValue2= "";
  // var minFee=TextEditingController();
  var maxFee=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Refine Your Search",style: TextStyle(fontWeight: FontWeight.bold))),backgroundColor: Colors.lightBlue,
        ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: maxFee,
                decoration: InputDecoration(
                            labelText: "Maximum Tuition Fee",
                            // hintText: "Enter Min Tuition Fee",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                // value: dropdownValue!,
                // icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                // underline: Container(
                //   height: 2,
                //   color: Colors.deepPurpleAccent,
                // ),
                decoration: InputDecoration(
                  labelText: "Board",
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
              child: DropdownButtonFormField<String>(
                // value: dropdownValue2,

                // icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                // underline: Container(
                //   height: 2,
                //   color: Colors.deepPurpleAccent,
                // ),
                decoration: InputDecoration(
                  labelText: "Area",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue2 = value!;
                  });
                },
                items: list2.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                // value: dropdownValue1,

                // icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                // underline: Container(
                //   height: 2,
                //   color: Colors.deepPurpleAccent,
                // ),
                decoration: InputDecoration(
                  labelText: "City",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue1 = value!;
                  });
                },
                items: list1.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width/1.2,
              child: ElevatedButton(
                onPressed: () =>Navigator.pop(context,[maxFee.text.toString(),dropdownValue,dropdownValue1,dropdownValue2]),
                    // Navigator.pushReplacement(
                    // context,
                    // MaterialPageRoute(
                    //   builder: (context) => allSchools(),
                    // )),
                child: Text("Apply",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),),
            )
          ],
        ),
      ),
    );
  }
}
