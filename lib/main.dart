import 'package:discovermyschool/adminPanel.dart';
import 'package:discovermyschool/login.dart';
import 'package:discovermyschool/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: AdminPanel(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          children: [
            Padding(padding:EdgeInsets.fromLTRB(0, 100, 0, 0)),
            Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize:50)),
            Container(
              // padding: EdgeInsets.all(15),
              // margin: EdgeInsets.all(15),
              width: 300,
              height: 300,
            child: Image.asset("logot.png"),
            ),
            Container(
              height: 150,
              width: 150,
              color: Colors.green,
            )
          ],
        ),

      ),
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
