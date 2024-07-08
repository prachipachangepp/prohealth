class ReferenceData {
  final int referenceId;
  final String association;
  final String comment;
  final String company;
  final String email;
  final String mobNumber;
  final int employeeId;
  final String name;
  final String references;
  final String title;
  final bool approve;
  ReferenceData({
    required this.approve,
    required this.referenceId,
    required this.association,
    required this.comment,
    required this.company,
    required this.email,
    required this.mobNumber,
    required this.employeeId,
    required this.name,
    required this.references,
    required this.title,
  });
}
