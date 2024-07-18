class RegisterEnrollData {
  final bool? success;
  final String? message;
  final int? empEnrollId;
  final int? compId;
  final int? empId;
  final String? code;
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? phoneNbr;
  final String? email;
  final String? link;
  final String? status;

  RegisterEnrollData({
    this.success,
    this.message,
    this.empEnrollId,
    this.compId,
    this.empId,
    this.userId,
    this.code,
    this.firstName,
    this.lastName,
    this.phoneNbr,
    this.email,
    this.link,
    this.status,
  });
}

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
