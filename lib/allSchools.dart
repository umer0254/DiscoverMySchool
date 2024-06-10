import 'dart:convert';

import 'package:discovermyschool/adminPanel.dart';
import 'package:discovermyschool/searchFilter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/Schools.dart';

class allSchools extends StatefulWidget {
  const allSchools({super.key});

  @override
  State<allSchools> createState() => _allSchoolsState();
}

class _allSchoolsState extends State<allSchools> {
  bool isLoading=false;
  List<School> SchoolsList=[];
  var result="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apidata();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Approved Schools"),backgroundColor:  Colors.lightBlue,
      ),drawer: drawer(),
      body: (isLoading && SchoolsList.isEmpty)? Center(
      child: CircularProgressIndicator(
        color: Colors.lightBlue,
      ),
    ):
    Column(
      children: [
        SizedBox(height: 15,),
        Stack(
          children: <Widget>[
            // SizedBox(height: 30,),
            // SearchBar(),
            // SearchBar(
            //   // controller: controller,
            //   padding: const MaterialStatePropertyAll<EdgeInsets>(
            //       EdgeInsets.symmetric(horizontal: 16.0)),
            //   onTap: () {
            //     // controller.openView();
            //   },
            //   onChanged: (_) {
            //     // controller.openView();
            //   },
            //   // leading: const Icon(Icons.search),
            //   trailing: <Widget>[
            //     Tooltip(
            //       message: 'Change brightness mode',
            //       child: IconButton(
            //         // isSelected: isDark,
            //         onPressed: () {
            //           setState(() {
            //             // isDark = !isDark;
            //           });
            //         },
            //         icon: Icon(Icons.search),
            //
            //         // selectedIcon: const Icon(Icons.brightness_2_outlined),
            //       ),
            //     ),
            //     IconButton(
            //       // isSelected: isDark,
            //       onPressed: () async {
            //        result= await Navigator.push(context, MaterialPageRoute(builder: (context) => Searchfilter(),));
            //         setState(() {
            //           // isDark = !isDark;
            //         });
            //       },
            //       icon: Icon(Icons.filter_list_alt)
            //     )
            //
            //   ],
            // )
            // Container(
            //   width: MediaQuery.sizeOf(context).width,
            //   height: 200.0,
            //   decoration: new BoxDecoration(
            //     color: Colors.deepPurple,
            //     borderRadius: BorderRadius.vertical(
            //         bottom: Radius.elliptical(
            //             MediaQuery.of(context).size.width, 100.0)),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text("Crimes of Category "+widget.category ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16))
            //     ],
            //   ),
            // ),
          ],
        ),
        // SingleChildScrollView(
        //   child: ListTile(
        //     title: Text(companies[0].title!),
        //   )
        // ),
        Expanded(
          child: ListView.builder( //CardView for all schools//
              itemCount: SchoolsList.length + 1,
              itemBuilder: (context, index) {
                if (index < SchoolsList.length) {
                  var c = SchoolsList[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    elevation: 1,
                    child:Container(
                      margin: EdgeInsets.all(10),
                      // padding:EdgeInsets.all(8),
                      // width:MediaQuery.sizeOf(context).width,
                      child:InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Table(
                            //   border: TableBorder.all(),
                            //   children: [
                            //     buildTableRow('Heading One         ', 'Value'),
                            //     buildTableRow('Heading Two   ', 'Value'),
                            //     // Add more rows as needed
                            //   ],
                            // ),
                            Wrap(
                              children: [
                                Container(width: 120,child: Text("School Name",style: TextStyle(fontWeight: FontWeight.bold))),
                                Text("${c.schoolName}",),
                              ],
                            ),

                            Wrap(
                              children: [
                                Container(width: 120,child: Text("Email",style: TextStyle(fontWeight: FontWeight.bold))),
                                Text("${c.email}"),
                              ],
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width: 120,child: Text("School Type",style: TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(child: Text(c.board??"",maxLines: null,)),
                              ],
                            ),

                            Wrap(
                              children: [
                                Container(width: 120,child: Text("Admission Fee",style: TextStyle(fontWeight: FontWeight.bold))),
                                Text("${c.admissionFee}"),
                              ],
                            ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(width:120 ,child: Text("Admission Status ",style: TextStyle(fontWeight: FontWeight.bold))),
                                  Expanded(child: Text(c.admissionStatus??"" ,maxLines: null,)),
                                ],
                              ),
                              Wrap(
                                children: [
                                  Container(width: 120,child: Text("Registration Date",style: TextStyle(fontWeight: FontWeight.bold))),
                                  Text("${c.createdAt??""}"),
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Container(width: 120,child: Text("Registration Date",style: TextStyle(fontWeight: FontWeight.bold))),
                                // IconButton(
                                //     onPressed: () {
                                //       // approval(c.id);
                                //     },
                                //     icon: Icon(Icons.check,color: Colors.green,semanticLabel: "Approve"),
                                //     iconSize: 30),
                                IconButton(
                                    onPressed: () {
                                      rejectapproval(c.id);
                                    },
                                    icon: Icon(Icons.close,color: Colors.red),
                                    iconSize: 30),
                              ],
                            ),




                          ],
                        ),
                        // onTap: () {
                        //   // Navigator.push(context, MaterialPageRoute(builder: (context) => SpecificLocation(id: c.location?.street.id??0),));
                        //
                        // },
                      ) ,
                    ),

                  );
                }
              }),
        )
      ],
    ),
    );
  }
  rejectapproval(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token=prefs.get('Token');
    String url;
    url = 'http://10.0.2.2:8000/api/unapproveSchool/${id}';
    try {

      final response = await http.put(Uri.parse(url),headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        setState(() {
          SchoolsList.clear();
          apidata();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unapproved successfully")));
        });
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AdminPanel(),), (route) => false);

      }
    }catch(e){
      print(e);
    }

  }
  apidata() async {
    String url;

    try {
      setState(() {
        isLoading=true;
      });
      Response response = await post(
        Uri.parse(
            'http://10.0.2.2:8000/api/getAllSchools'),
        body: {
          // "email": email,
          // "password": password
        },
      );
      if (response.statusCode == 200) {

        var data = json.decode(response.body);
        print(data);
        final List<dynamic> items = data['schools'];
        var schoolData = items.map((item) => School.fromJson(item)).toList();
        SchoolsList.addAll(schoolData);


        setState(() {
          isLoading=false;
        });

      }
      else{
        setState(() {
          isLoading=false;
        });


      }
    } catch (e) {
      print(e);
    }
  }

}
// class SearchBarApp extends StatefulWidget {
//   const SearchBarApp({super.key});
//
//   @override
//   State<SearchBarApp> createState() => _SearchBarAppState();
// }
//
// class _SearchBarAppState extends State<SearchBarApp> {
//   bool isDark = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData themeData = ThemeData(
//         useMaterial3: true,
//         brightness: isDark ? Brightness.dark : Brightness.light);
//
//     return MaterialApp(
//       theme: themeData,
//       home: Scaffold(
//         // appBar: AppBar(title: const Text('Search Bar Sample')),
//         body: Padding(
//           padding: const EdgeInsets.all(1.0),
//           child: SearchAnchor(
//               builder: (BuildContext context, SearchController controller) {
//                 return SearchBar(
//                   controller: controller,
//                   padding: const MaterialStatePropertyAll<EdgeInsets>(
//                       EdgeInsets.symmetric(horizontal: 20.0)),
//                   onTap: () {
//                     controller.openView();
//                   },
//                   onChanged: (_) {
//                     controller.openView();
//                   },
//                   leading: const Icon(Icons.search),
//                   trailing: <Widget>[
//                  IconButton(onPressed: () {
//
//                  }, icon:Icon(Icons.search))
//                   ],
//                 );
//               }, suggestionsBuilder:
//               (BuildContext context, SearchController controller) {
//             return List<ListTile>.generate(5, (int index) {
//               final String item = 'item $index';
//               return ListTile(
//                 title: Text(item),
//                 onTap: () {
//                   setState(() {
//                     controller.closeView(item);
//                   });
//                 },
//               );
//             });
//           }),
//         ),
//       ),
//     );
//   }
// }
