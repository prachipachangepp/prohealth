class CiVisit{
  final String typeofVisit;
  final String? eligibleClinician;
  final int? visitId;
  final int? employeeTypeId;
  final bool sucess;
  final String message;
  CiVisit({this.employeeTypeId,this.visitId,required this.sucess, required this.message,required this.typeofVisit, this.eligibleClinician});
}

class CiVisitAdd{
  final String? visitType;
  final List? eligibleClinician;
  CiVisitAdd({this.visitType, this.eligibleClinician});
}