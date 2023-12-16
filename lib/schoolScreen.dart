import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({super.key});

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("School",style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
