class CiVisit {
  final String typeofVisit;
  final List<CiVisitList>? eligibleClinician;
  final int visitId;
  final int? employeeTypeId;
  final bool sucess;
  final String message;
  CiVisit(
      {this.employeeTypeId,
      required this.visitId,
      required this.sucess,
      required this.message,
      required this.typeofVisit,
      this.eligibleClinician});
}

class CiVisitList {
  final String eligibleClinician;
  final int empTypeId;
  final String color;
  CiVisitList({
    required this.color,
    required this.eligibleClinician,
    required this.empTypeId,
  });
}

class VisitListData {
  final String visitType;
  final int companyId;
  final int visitId;
  final bool sucess;
  final String message;
  VisitListData(
      {required this.sucess,
      required this.message,
      required this.companyId,
      required this.visitId,
      required this.visitType});
}

class CiVisitAdd {
  final String? visitType;
  final List? eligibleClinician;
  CiVisitAdd({this.visitType, this.eligibleClinician});
}
