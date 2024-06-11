import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:discovermyschool/adminPanel.dart';
import 'package:discovermyschool/login.dart';
import 'package:discovermyschool/splashScreen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the notification plugin
  await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'school_notification',
          channelName: 'School Admission',
          channelDescription: 'Admission Opened',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
      debug: true
  );

  // Request notification permissions


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: splashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 300,
              child: Image.asset("logot.png"),
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              width: 150,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
