class EducationData {
  final int educationId;
  final int employeeID;
  final String graduate;
  final String degree;
  final String major;
  final String city;
  final String college;
  final String phone;
  final String state;
  bool? approved;
  EducationData({
    this.approved,
    required this.educationId,
    required this.employeeID,
    required this.graduate,
    required this.degree,
    required this.major,
    required this.city,
    required this.college,
    required this.phone,
    required this.state,
  });
}
