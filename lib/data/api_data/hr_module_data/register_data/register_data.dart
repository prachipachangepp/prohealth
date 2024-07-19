class RegisterEnrollData {
  // final bool success;
  // final String message;
  final int empEnrollId;
  final int compId;
  final int empId;
  final String code;
  final int userId;
  final String firstName;
  final String lastName;
  final String phoneNbr;
  final String email;
  final String link;
  final String status;

  RegisterEnrollData({
    // required this.success,
    // required this.message,
    required this.empEnrollId,
    required this.compId,
    required this.empId,
    required this.userId,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.phoneNbr,
    required this.email,
    required this.link,
    required this.status,
  });
}
///employee-enroll/{employeeEnrollId}
class RegisterDataPrefill {
  final int empEnrollId;
  final int compId;
  final int empId;
  final String code;
  final int userId;
  final String firstName;
  final String lastName;
  final String phoneNbr;
  final String email;
  final String link;
  final String status;

  RegisterDataPrefill({
    required this.empEnrollId,
    required this.compId,
    required this.empId,
    required this.code,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNbr,
    required this.email,
    required this.link,
    required this.status,
  });
}
