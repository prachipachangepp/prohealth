//by comp id
class RegisterDataCompID {
  final int userId;
  final String firstName;
  final String lastName;
  final String role;
  final String email;
  final int company_id;
  final String status;


  RegisterDataCompID({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.email,
    required this.company_id,
    required this.status,
  });
}

///by comp id by status
class RegisterDataCompIDStatus {

  final int userId;
  final String firstName;
  final String lastName;
  final String role;
  final String email;
  final int company_id;
  final String status;

  RegisterDataCompIDStatus({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.email,
    required this.company_id,
    required this.status,
  });
}

///users/{userId} prefill
class RegisterDataUserIDPrefill {

  final int userId;
  final String firstName;
  final String lastName;
  final String role;
  final String email;
  final int company_id;
  final String status;

  RegisterDataUserIDPrefill({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.email,
    required this.company_id,
    required this.status,
  });
}
