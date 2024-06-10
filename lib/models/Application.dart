import 'package:discovermyschool/models/Schools.dart';

class Application {
  int id;
  int studentId;
  int schoolId;
  String remarks;
  String status;
  School school;
  DateTime createdAt;
  DateTime updatedAt;

  Application({
    required this.id,
    required this.studentId,
    required this.schoolId,
    required this.remarks,
    required this.status,
    required this.school,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      schoolId: json['school_id'] ?? 0,
      remarks: json['remarks'] ?? "",
      status: json['status'] ?? "",
      school: School.fromJson(json['school'] ?? {}),
      createdAt: DateTime.parse(json['created_at'] ?? ""),
      updatedAt: DateTime.parse(json['updated_at'] ?? ""),
    );
  }
}
