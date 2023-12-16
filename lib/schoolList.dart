import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SchoolList extends StatefulWidget {
  const SchoolList({super.key});

  @override
  State<SchoolList> createState() => _SchoolListState();
}

class _SchoolListState extends State<SchoolList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SchoolsList"),
      ),
    );
  }
}
