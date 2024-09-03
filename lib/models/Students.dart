import 'package:flutter/material.dart';

class Student {
  final int id;
  final int userId;
  final String studentName;
  final DateTime dateOfBirth;
  final String fatherOccupation;
  final String fatherName;
  final String fatherEducation;
  final String motherName;
  final String motherEducation;
  final String motherOccupation;
  final String address;
  final String fatherCNIC;
  final String studentCNIC;
  final String applyingForClass;
  final DateTime createdAt;
  final DateTime updatedAt;

  Student({
    required this.id,
    required this.userId,
    required this.studentName,
    required this.dateOfBirth,
    required this.fatherOccupation,
    required this.fatherName,
    required this.fatherEducation,
    required this.motherName,
    required this.motherEducation,
    required this.motherOccupation,
    required this.address,
    required this.fatherCNIC,
    required this.studentCNIC,
    required this.applyingForClass,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      userId: json['user_id'],
      studentName: json['student_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      fatherOccupation: json['father_occupation'],
      fatherName: json['father_name'],
      fatherEducation: json['father_education'],
      motherName: json['mother_name'],
      motherEducation: json['mother_education'],
      motherOccupation: json['mother_occupation'],
      address: json['address'],
      fatherCNIC: json['father_cnic'],
      studentCNIC: json['student_cnic'],
      applyingForClass: json['applying_for_class'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }


}
