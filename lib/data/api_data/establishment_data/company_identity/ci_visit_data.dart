class CiVisit{
  final String? typeofVisit;
  final String? eligibleClinician;
  final int? visitId;
  final bool sucess;
  final String message;
  CiVisit(  {this.visitId,required this.sucess, required this.message,this.typeofVisit, this.eligibleClinician});
}

class CiVisitAdd{
  final String? visitType;
  final String? eligibleClinician;
  CiVisitAdd({this.visitType, this.eligibleClinician});
}