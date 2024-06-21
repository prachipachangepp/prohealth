class CiVisit{
  final String typeofVisit;
  final List<CiVisitList>? eligibleClinician;
  final int? visitId;
  final int? employeeTypeId;
  final bool sucess;
  final String message;
  CiVisit({this.employeeTypeId,this.visitId,required this.sucess, required this.message,required this.typeofVisit, this.eligibleClinician});
}
class CiVisitList{
  final String eligibleClinician;
  final int empTypeId;
  final String color;
  CiVisitList({required this.color,required this.eligibleClinician, required this.empTypeId,});
}

class CiVisitAdd{
  final String? visitType;
  final List? eligibleClinician;
  CiVisitAdd({this.visitType, this.eligibleClinician});
}