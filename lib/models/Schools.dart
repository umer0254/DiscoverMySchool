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
  String board;
  String area;
  String city;
  String schoolImage;
  int adminId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  String principalName;
  String principalContact;
  String principalQualifications;
  String principalBiography;
  String missionStatement;
  String schoolHistory;
  String facilities;
  String extracurricularActivities;

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
    required this.board,
    required this.area,
    required this.city,
    required this.schoolImage,
    required this.adminId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.principalName,
    required this.principalContact,
    required this.principalQualifications,
    required this.principalBiography,
    required this.missionStatement,
    required this.schoolHistory,
    required this.facilities,
    required this.extracurricularActivities,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'] ?? 0,
      schoolName: json['school_name'] ?? "",
      email: json['email'] ?? "",
      address: json['address'] ?? "",
      contactNumber: json['contact_number'] ?? "",
      isApproved: json['is_approved'] ?? 0,
      admissionFee: double.parse(json['admission_fee'] ?? "0"),
      admissionStatus: json['admission_status'] ?? "",
      tuitionFee: double.parse(json['tuition_fee'] ?? "0"),
      board: json['board'] ?? "",
      area: json['area'] ?? "",
      city: json['city'] ?? "",
      schoolImage: json['school_image'] ?? "Image Not Available",
      adminId: json['admin_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? ""),
      updatedAt: DateTime.parse(json['updated_at'] ?? ""),
      principalName: json['principal_name'] ?? "",
      principalContact: json['principal_contact'] ?? "",
      principalQualifications: json['principal_qualifications'] ?? "",
      principalBiography: json['principal_biography'] ?? "",
      missionStatement: json['mission_statement'] ?? "",
      schoolHistory: json['school_history'] ?? "",
      facilities: json['facilities'] ?? "",
      extracurricularActivities: json['extracurricular_activities'] ?? "",
    );
  }
}
