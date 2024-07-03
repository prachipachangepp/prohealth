class AEClinical {
  final bool? success;
  final String? message;
  final String? empType;
  final String? abbrivation;
  final int? deptID;
  final String? color;
  final int employeeTypesId;

  AEClinical(  {
    required this.employeeTypesId,
    this.success, this.message, this.empType, this.deptID,this.abbrivation, this.color});
}