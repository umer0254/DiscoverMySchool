class School {
  int id;
  String schoolName;
  String email;
  String address;
  String contactNumber;
  int isApproved;
  double admissionFee;
  String admissionStatus;
  double tuitionFee;
  String schoolType;
  int adminId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  School({
    required this.id,
    required this.schoolName,
    required this.email,
    required this.address,
    required this.contactNumber,
    required this.isApproved,
    required this.admissionFee,
    required this.admissionStatus,
    required this.tuitionFee,
    required this.schoolType,
    required this.adminId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    // print("JSON Data: $json");
    return School(
      id: json['id']??0,
      schoolName: json['school_name']??"",
      email: json['email']??"",
      address: json['address']??"",
      contactNumber: json['contact_number']??"",
      isApproved: json['is_approved']??0,
      admissionFee: double.parse(json['admission_fee']??""),
      admissionStatus: json['admission_status']??"",
      tuitionFee: double.parse(json['tuition_fee']??""),
      schoolType: json['school_type']??"",
      adminId: json['admin_id']??0,
      userId: json['user_id']??0,
      createdAt: DateTime.parse(json['created_at']??""),
      updatedAt: DateTime.parse(json['updated_at']??""),
    );
  }
}
