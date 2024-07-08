///
class UserModal {
  final int userId;
  final String firstName;
  final String lastName;
  final String role;
  final int companyId;
  final String email;
  final bool sucess;
  final String message;

  UserModal({
    required this.sucess,
    required this.message,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.companyId,
    required this.email,
  });
}

/// Get prefill user
class UserModalPrefill {
  final int userId;
  final String firstName;
  final String lastName;
  final String role;
  final int companyId;
  final String email;
  final bool sucess;
  final String message;

  UserModalPrefill({
    required this.sucess,
    required this.message,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.companyId,
    required this.email,
  });
}
