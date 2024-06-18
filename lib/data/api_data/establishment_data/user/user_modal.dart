///
class UserModal{
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? role;
  final int? companyId;
  final String? email;

  UserModal(
      {
      required  this.userId,
        required  this.firstName,
        required  this.lastName,
        required  this.role,
        required  this.companyId,
        required  this.email,
      });
}